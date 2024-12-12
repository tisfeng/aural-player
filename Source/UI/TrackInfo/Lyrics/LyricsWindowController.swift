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

    // Timer to update elapsed time
    private var updateTimer: Timer?

    lazy var messenger = Messenger(for: self)

    override init(window: NSWindow?) {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 500),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.center()

        super.init(window: window)

        setupLyricsView()
        setupNotifications()

        updateTrack()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    }

    convenience init(track: MusicTrack?, lyrics: Lyrics?) {
        self.init(window: nil)
        updateTrack()
    }

    private func createLyricsView(
        track: MusicTrack? = nil,
        lyrics: Lyrics? = nil,
        elapsedTime: Double = 0,
        isPlaying: Bool = false
    ) -> LyricsScrollView {
        LyricsScrollView(
            track: track,
            lyrics: lyrics,
            elapsedTime: elapsedTime,
            isPlaying: isPlaying
        ) { [weak self] index, proxy in
            let position = self?.lyrics?[index].position ?? 0
            self?.messenger.publish(.Player.jumpToTime, payload: position)

            print("Tap to seek position \(position)")
        }
    }

    private func setupLyricsView() {
        let lyricsView = createLyricsView()
        self.lyricsView = lyricsView
        let hostingView = NSHostingView(rootView: lyricsView)
        self.hostingView = hostingView
        window?.contentView = hostingView
    }

    private func setupNotifications() {
        messenger.subscribeAsync(to: .Player.trackTransitioned, handler: trackTransitioned)
        messenger.subscribeAsync(to: .Player.trackInfoUpdated, handler: trackInfoUpdated(_:))
        messenger.subscribeAsync(to: .Player.trackNotPlayed, handler: trackTransitioned)
        messenger.subscribeAsync(to: .Player.playbackStateChanged, handler: playbackStateChanged)
        messenger.subscribeAsync(to: .Player.seekPerformed, handler: seekPerformed)
        
        // Start update timer
        startUpdateTimer()
    }

    // Start timer to update elapsed time
    private func startUpdateTimer() {
        stopUpdateTimer()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let newElapsedTime = playbackDelegate.seekPosition.timeElapsed
            if newElapsedTime != self.elapsedTime {
//                print("LyricsWindowController: Elapsed time updated: \(newElapsedTime)")

                self.elapsedTime = newElapsedTime
                self.updateTrack()
            }
        }
    }
    
    // Stop update timer
    private func stopUpdateTimer() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    deinit {
        stopUpdateTimer()
    }

    // MARK: - Update UI

    func updateTrack(_ track: Track? = nil, lyrics: Lyrics? = nil) {
        let oldTrack = self.track
        self.track = track ?? playbackDelegate.playingTrack

        let lyricsText = self.track?.lyrics ?? ""
        self.lyrics = lyrics ?? Lyrics(lyricsText)

        self.elapsedTime = playbackDelegate.seekPosition.timeElapsed
        self.isPlaying = playbackDelegate.state == .playing

        DispatchQueue.main.async { [self] in
            // Create new lyricsView when track changes or lyricsView is nil
            if self.track != oldTrack || lyricsView == nil {
                let newLyricsView = self.createLyricsView(
                    track: self.track?.musicTrack,
                    lyrics: self.lyrics,
                    elapsedTime: self.elapsedTime,
                    isPlaying: self.isPlaying
                )

                self.lyricsView = newLyricsView
                self.hostingView?.rootView = newLyricsView
            } else {
                // If track hasn't changed, just update the playback position
                self.lyricsView?.seekTo(position: self.elapsedTime, isPlaying: self.isPlaying)
            }
        }
    }

    // MARK: - Notification Handlers

    private func trackTransitioned(_ notif: TrackTransitionNotification) {
        print("LyricsWindowController: Track transitioned")
        updateTrack(notif.endTrack)
    }

    private func trackInfoUpdated(_ notif: TrackInfoUpdatedNotification) {
        print("LyricsWindowController: Track info updated")
    }

    /// Handle play or pause event.
    private func playbackStateChanged() {
        print("LyricsWindowController: Playback state changed")
        updateTrack()
    }

    private func seekPerformed() {
        print("LyricsWindowController: Seek performed")
        updateTrack()
    }
}

extension Track {
    var musicTrack: MusicTrack {
        MusicTrack(id: title ?? "", title: title, album: album, artist: artist, duration: duration)
    }
}
