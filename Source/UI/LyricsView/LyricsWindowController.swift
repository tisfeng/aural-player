//
//  LyricsWindowController.swift
//  Aural
//
//  Created by tisfeng on 2024/12/3.
//

import Cocoa
import LyricsCore
import MusicPlayer
import SwiftUI

/// Controller for the Lyrics window, host LyricsScrollView
class LyricsWindowController: NSWindowController {

    private var hostingView: NSHostingView<LyricsScrollView>?
    private var lyricsView: LyricsScrollView?

    private var track: Track?
    private var lyrics: Lyrics?
    private var elapsedTime: Double = 0
    private var isPlaying: Bool = false

    lazy var messenger = Messenger(for: self)

    override init(window: NSWindow?) {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: lyricsWidth, height: lyricsHeight),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.identifier = .init(rawValue: WindowID.lyrics.rawValue)
        window.center()

        super.init(window: window)

        updateLyricsView()

        setupNotifications()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    }

    convenience init(track: Track?, lyrics: Lyrics?) {
        self.init(window: nil)

        self.track = track
        self.lyrics = lyrics
        updateLyricsView()
    }

    // MARK: - View Management

    private func updateLyricsView() {
        let lyricsView = LyricsScrollView(
            track: track?.musicTrack,
            lyrics: lyrics,
            elapsedTime: elapsedTime,
            isPlaying: isPlaying
        ) { [weak self] index, proxy in
            let position = self?.lyrics?[index].position ?? 0
            self?.messenger.publish(.Player.jumpToTime, payload: position)
        }

        self.lyricsView = lyricsView

        if hostingView == nil {
            hostingView = NSHostingView(rootView: lyricsView)
            window?.contentView = hostingView
        } else {
            hostingView?.rootView = lyricsView
        }

        lyricsView.seekTo(position: elapsedTime, isPlaying: isPlaying)
    }

    // MARK: - Setup

    private func setupNotifications() {
        messenger.subscribeAsync(to: .Player.trackTransitioned, handler: trackTransitioned)
        messenger.subscribeAsync(to: .Player.trackInfoUpdated, handler: trackInfoUpdated(_:))
        messenger.subscribeAsync(to: .Player.trackNotPlayed, handler: trackTransitioned)
        messenger.subscribeAsync(to: .Player.playbackStateChanged, handler: playbackStateChanged)
        messenger.subscribeAsync(to: .Player.seekPerformed, handler: seekPerformed)
    }

    // MARK: - Update Methods

    private func updateTrackInfo() {
        track = playbackDelegate.playingTrack
        lyrics = getLyrics(from: track)
        updatePlaybackState()

        DispatchQueue.main.async {
            self.updateLyricsView()
        }
    }

    private func getLyrics(from track: Track?) -> Lyrics? {
        guard let track = track else {
            return nil
        }
        
        // 1. First try to find lyrics from lrc/lrcx file
        if let lyricsFromFile = findLyricsFile(for: track.file) {
            do {
                let lyricsText = try String(contentsOf: lyricsFromFile, encoding: .utf8)
                return Lyrics(lyricsText)
            } catch {
                print("Error reading lyrics file: \(error)")
            }
        }
        
        // 2. Fallback to embedded lyrics
        return Lyrics(track.lyrics ?? "")
    }
    
    private func findLyricsFile(for audioFile: URL) -> URL? {
        let directory = audioFile.deletingLastPathComponent()
        let filename = audioFile.deletingPathExtension().lastPathComponent
        
        // Try .lrc first, then .lrcx
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

    private func updatePlaybackState() {
        elapsedTime = playbackDelegate.seekPosition.timeElapsed
        isPlaying = playbackDelegate.state == .playing
    }

    // MARK: - Notification Handlers

    private func trackTransitioned(_ notif: TrackTransitionNotification) {
        updateTrackInfo()
    }

    private func trackInfoUpdated(_ notif: TrackInfoUpdatedNotification) {
        updateTrackInfo()
    }

    private func playbackStateChanged() {
        updateTrackInfo()
    }

    private func seekPerformed() {
        updateTrackInfo()
    }

    deinit {
        messenger.unsubscribeFromAll()
    }
}

extension Track {
    var musicTrack: MusicTrack {
        MusicTrack(id: title ?? "", title: title, album: album, artist: artist, duration: duration)
    }
}
