//
//  FFmpegReplayGainScanner+Int32.swift
//  Aural
//
//  Copyright © 2024 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//

import Foundation

extension FFmpegReplayGainScanner {
    
    func scanAsInt32() throws -> EBUR128AnalysisResult? {
        
        defer {
            self.cleanUpAfterScan()
        }
        
        do {
            
            var curSize: Int = 0
            let sizeOfAFrame = MemoryLayout<Int32>.size * channelCount
            
            while !eof, consecutiveErrors < 3 {
                
                do {
                    
                    guard let pkt = try ctx.readPacket(from: stream) else {
                        
                        consecutiveErrors += 1
                        continue
                    }
                    
                    let frames = try codec.decode(packet: pkt)
                    
                    for frame in frames.frames {
                        
                        // Only 1 buffer since interleaved. Capacity = sampleCount * number of bytes in Int16 * channelCount
                        let newSize = frame.intSampleCount * sizeOfAFrame
                        
                        if newSize > curSize {
                            
                            outputData?[0] = .allocate(capacity: newSize)
                            curSize = newSize
                        }
                        
                        swr?.convertFrame(frame, andStoreIn: outputData)
                        
                        let pointer: UnsafeMutablePointer<UInt8>? = outputData?[0] ?? frame.dataPointers[0]
                        
                        pointer?.withMemoryRebound(to: Int32.self, capacity: frame.intSampleCount) {pointer in
                            
                            do {
                                
                                try ebur128.addFramesAsInt32(framesPointer: pointer, frameCount: frame.intSampleCount)
                                consecutiveErrors = 0
                                
                            } catch let err as EBUR128Error {
                                print(err.description)
                                
                            } catch {
                                print("Unknown error: \(error.localizedDescription)")
                            }
                        }
                    }
                    
                } catch let err as DecoderError {
                    
                    eof = err.isEOF
                    
                    if !err.isEOF {
                        
                        consecutiveErrors += 1
                        print("Error: \(err.code.errorDescription)")
                    }
                    
                } catch let err as PacketReadError {
                    
                    eof = err.isEOF
                    
                    if !err.isEOF {
                        
                        consecutiveErrors += 1
                        print("Error: \(err.code.errorDescription)")
                    }
                }
            }
            
        } catch {
            print("Error: \(error)")
        }
        
        return consecutiveErrors >= 3 ? nil : try ebur128.analyze()
    }
}
