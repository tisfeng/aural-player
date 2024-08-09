//
//  WaveformView.swift
//  Periphony: Spatial Audio Player
//  Copyright © Oli Larkin Plug-ins Ltd. 2022. All rights reserved.
//  Developed by Kartik Venugopal
//

import Accelerate
import Cocoa
import os

protocol SampleReceiver {
    
    func setSamples(_ samples: [[Float]])
}

///
/// A view that renders and displays waveforms for audio files.
///
/// **Notes**
///
/// This is based on ``FDWaveformView``.
///
/// - SeeAlso:      https://github.com/fulldecent/FDWaveformView
///
class WaveformView: NSView, SampleReceiver {
    
    static let noiseFloor: CGFloat = -50
    
    var clickRecognizer: NSClickGestureRecognizer!
    
    var _audioFile: URL?
    var renderOp: WaveformRenderOperation?
    
    var waveformSize: NSSize = .zero
    
    required init?(coder: NSCoder) {

        super.init(coder: coder)
        
        self.waveformSize = self.bounds.size
        self.wantsLayer = true
        addGestureRecognizers()
        
        colorSchemesManager.registerSchemeObserver(self)
        colorSchemesManager.registerPropertyObserver(self, forProperty: \.activeControlColor, handler: activeControlColorChanged(_:))
        colorSchemesManager.registerPropertyObserver(self, forProperty: \.inactiveControlColor, handler: inactiveControlColorChanged(_:))
    }
    
    var samples: [[Float]] = [[],[]]
    
    func setSamples(_ samples: [[Float]]) {
        
        self.samples = samples
        
        DispatchQueue.main.async {
            self.redraw()
        }
    }
    
    var samplesProgress: CGFloat {
        CGFloat(samples[0].count) / bounds.width
    }
    
    func resetState() {
        
        samples = [[],[]]
        progress = 0
        baseLayerComplete = false
        redraw()
    }
    
    // Between 0 and 1
    var progress: CGFloat = 0 {
        
        didSet(newValue) {
            
            if newValue < 0 {
                self.progress = 0
                
            } else if newValue > 1 {
                self.progress = 1
            }
            
            redraw()
        }
    }
    
    var baseLayerComplete: Bool = false
    
    var maskLayer: CALayer? {
        
        if let subLayers = layer?.sublayers, subLayers.count >= 2 {
            return subLayers[1].mask
        }
        
        return nil
    }
    
    var baseLayer: CAShapeLayer? {
        layer?.sublayers?.first as? CAShapeLayer
    }
    
    var progressLayer: CAShapeLayer? {
        
        if let subLayers = layer?.sublayers, subLayers.count >= 2 {
            return subLayers[1] as? CAShapeLayer
        }
        
        return nil
    }
    
    override func draw(_ dirtyRect: NSRect) {
        
        super.draw(dirtyRect)
        
        let samplesToDraw = self.samples
        
//        let scaleFactor: CGFloat = window?.screen?.backingScaleFactor ?? NSScreen.main!.backingScaleFactor
        let scaleFactor: CGFloat = 1
        let scaledImageSize = bounds
        
        let scaledWidth = scaledImageSize.width
        let scaledHeight = scaledImageSize.height
        
        guard !baseLayerComplete else {
            
            if let maskLayer = self.maskLayer {
                
                maskLayer.frame = CGRect(x: 0, y: 0, width: scaledWidth * progress, height: scaledHeight)
                maskLayer.removeAllAnimations()
            }
            return
        }
        
        layer?.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
        
        // ------------------------------------------------------------------------------------------
        
        // MARK: Create and configure a CALayer to do the drawing.
        
        let baseLayer = CAShapeLayer()
        baseLayer.frame = CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight)
        baseLayer.strokeColor = systemColorScheme.inactiveControlColor.cgColor
        baseLayer.fillColor = NSColor.clear.cgColor
        baseLayer.lineWidth = 1.0
        
        // ------------------------------------------------------------------------------------------
        
        // MARK: Compute some parameters for the drawing.
        
        /// Number of audio channels (i.e. number of waveforms) being rendered.
        let channelCount = samplesToDraw.count
        
        /// The minimum of all sample (amplitude) values.
        let minVal: Float = -50
        
        /// The maximum of all sample (amplitude) values.
        let maxVal: Float = samplesToDraw.sampleMax
        
        /// The height of the waveform for each individual audio channel.
        let channelHeight = scaledHeight / CGFloat(channelCount)
        
        /// Half of ``channelHeight``.
        let halfChannelHeight = channelHeight / 2
        
        /// A factor / multiplier for the height of each sample.
        let sampleDrawingScale: CGFloat
        
        if maxVal == minVal {
            sampleDrawingScale = 0
        } else {
            sampleDrawingScale = (channelHeight * scaleFactor) / 2 / CGFloat(maxVal - minVal)
        }
        
        /// This bezier path will contain all our data points (lines).
        let path = NSBezierPath()
        
        let samplesDrawn = samplesToDraw[0].count

        // ------------------------------------------------------------------------------------------
        
        // MARK: Iterate through all the audio channels.
        
        for (index, channelSamples) in samplesToDraw.enumerated() {
            
            // ------------------------------------------------------------------------------------------
            
            // MARK: Draw a zero amplitude line across the vertical center of the waveform.

            /// The halfway point along the Y axis.
            let verticalMiddle = (CGFloat(channelCount - index - 1) * channelHeight + halfChannelHeight) * scaleFactor
            
            // Draw 3 lines, to prevent the zero amplitude indicator from disappearing.
            
            let lineEndX = scaledWidth * scaleFactor
            
            path.line(from: (x: 0, y: verticalMiddle), to: (x: lineEndX, y: verticalMiddle))
            
            // ------------------------------------------------------------------------------------------
            
            // MARK: Draw the samples.
            
            for (x, sample) in channelSamples.enumerated() {
                
                let height = CGFloat(CGFloat(sample - minVal) * sampleDrawingScale)
                let x_CGFloat = CGFloat(x)
                
                if height.isZero || height.isNaN {
                    
                    print("WTF!")
                    continue
                }
                
                // TODO: Clamp values to prevent zero or negative height lines
                path.line(from: (x_CGFloat, verticalMiddle - height), to: (x_CGFloat, verticalMiddle + height))
            }
        }
        
        // ------------------------------------------------------------------------------------------
        
        // MARK: Set up the mask layer (for progress)
        
        baseLayer.path = path.cgPath
        self.layer?.addSublayer(baseLayer)
        
        if let progressLayer = baseLayer.deepCopy() as? CAShapeLayer {
            
            progressLayer.strokeColor = systemColorScheme.activeControlColor.cgColor
            self.layer?.addSublayer(progressLayer)
            
            let mask = CAShapeLayer()
            mask.frame = CGRect(x: 0, y: 0, width: scaledWidth * progress, height: scaledHeight)
            mask.backgroundColor = progressLayer.strokeColor
            mask.removeAllAnimations()
            progressLayer.mask = mask
        }
        
        if samplesDrawn >= Int(bounds.width) {
            baseLayerComplete = true
        }
    }
}

extension WaveformView: ColorSchemeObserver {
    
    func colorSchemeChanged() {
        
        baseLayerComplete = false
        
        baseLayer?.strokeColor = systemColorScheme.inactiveControlColor.cgColor
        progressLayer?.strokeColor = systemColorScheme.activeControlColor.cgColor
        maskLayer?.backgroundColor = progressLayer?.strokeColor
        
        redraw()
    }
    
    func activeControlColorChanged(_ newColor: NSColor) {
        
        progressLayer?.strokeColor = newColor.cgColor
        maskLayer?.backgroundColor = progressLayer?.strokeColor
    }
    
    func inactiveControlColorChanged(_ newColor: NSColor) {
        baseLayer?.strokeColor = newColor.cgColor
    }
}

fileprivate extension Array where Element == Float {

    ///
    /// An efficient way to find the maximum value in a ``Float`` array
    /// using Accelerate.
    ///
    func fastMax() -> Float {

        var max: Float = 0
        vDSP_maxv(self, 1, &max, UInt(count))
        return max
    }
}

extension [[Float]] {
    
    var sampleMax: Float {
       
        // Use Accelerate to compute the maximums for each channel efficiently.
        let allMaximums = self.map {$0.fastMax()}
        
        // Return the maximum value within ``allMaximums``.
        return Float(allMaximums.max() ?? 0)
    }
}
