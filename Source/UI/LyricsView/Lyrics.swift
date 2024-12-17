//
//  Lyrics.swift
//  Aural
//
//  Created by tisfeng on 2024/12/17.
//  Copyright © 2024 Kartik Venugopal. All rights reserved.
//

import Foundation
import LyricsCore

func getLyrics(from track: Track?) -> Lyrics? {
    guard let track = track else {
        return nil
    }

    // 1. First try to find lyrics from lyrics directory
    if let lyrics = readLyrics(for: track, in: FilesAndPaths.lyricsDir) {
        return lyrics
    }

    // 2. Then try to find lyrics from audio file directory
    if let lyrics = readLyrics(for: track, in: track.file.deletingLastPathComponent()) {
        return lyrics
    }

    // 3. Fallback to embedded lyrics
    if let lyrics = track.lyrics {
        return Lyrics(lyrics)
    }

    return nil
}


func readLyrics(for track: Track, in directory: URL) -> Lyrics? {
    if let lyricsFile = findLyricsFile(for: track, in: directory) {
        return readLyrics(from: lyricsFile)
    }
    return nil
}


/// Tries to find a lyrics file for a given track in the specified directory.
private func findLyricsFile(for track: Track, in directory: URL) -> URL? {
    let filename = track.file.deletingPathExtension().lastPathComponent

    // Try .lrc first, then .lrcx in audio file directory
    let lrcFile = directory.appendingPathComponent(filename + ".lrc")
    let lrcxFile = directory.appendingPathComponent(filename + ".lrcx")

    let fileManager = FileManager.default

    if fileManager.fileExists(atPath: lrcFile.path) {
        return lrcFile
    }

    if fileManager.fileExists(atPath: lrcxFile.path) {
        return lrcxFile
    }

    return nil
}

/// Get lyrics from URL.
func readLyrics(from url: URL) -> Lyrics? {
    do {
        let lyricsText = try String(contentsOf: url, encoding: .utf8)
        return Lyrics(lyricsText)
    } catch {
        print("Error reading lyrics file from url: \(error)")
    }

    return nil
}

