//
//  LyricsWindowController.swift
//  Aural
//
//  Created by tisfeng on 2024/12/3.
//  Copyright © 2024 Kartik Venugopal. All rights reserved.
//

import Cocoa
import LyricsCore
import MusicPlayer
import SwiftUI

/// Controller for the Lyrics window, host LyricsScrollView
class LyricsWindowController: NSWindowController {

    private var hostingView: NSHostingView<LyricsScrollView>?
    private var lyricsView: LyricsScrollView?

    private var currentTrack: MusicTrack?
    private var currentLyrics: Lyrics?
    private var currentElapsedTime: Double = 0
    private var isPlaying: Bool = false

    lazy var messenger = Messenger(for: self)

    override init(window: NSWindow?) {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Lyrics"
        window.center()

        super.init(window: window)

        setupLyricsView()
        setupNotifications()

        update()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    }

    convenience init(track: MusicTrack?, lyrics: Lyrics?) {
        self.init(window: nil)
        updateLyricsView(track: track, lyrics: lyrics)
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
        ) { [weak self] position in
            print("Tap to seek position \(position)")
            self?.messenger.publish(.Player.jumpToTime, payload: position)
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
        messenger.subscribe(to: .Player.trackInfo_refresh, handler: trackInfoRefresh)
        messenger.subscribeAsync(to: .Player.trackTransitioned, handler: trackTransitioned)
        messenger.subscribeAsync(to: .Player.trackInfoUpdated, handler: trackInfoUpdated(_:))
        messenger.subscribeAsync(to: .Player.trackNotPlayed, handler: trackTransitioned)
        messenger.subscribeAsync(to: .Player.playbackStateChanged, handler: playbackStateChanged)
        messenger.subscribeAsync(to: .Player.seekPerformed, handler: seekPerformed)
    }

    // MARK: - Update UI

    func update(track: Track? = nil, elapsedTime: Double = 0) {
        let playingTrack = track ?? playbackDelegate.playingTrack
        let lyrics = Lyrics(playingTrack?.lyrics ?? "")

        let elapsedTime = elapsedTime > 0 ? elapsedTime : playbackDelegate.seekPosition.timeElapsed

        updateLyricsView(
            track: playingTrack?.musicTrack,
            lyrics: lyrics,
            elapsedTime: elapsedTime,
            isPlaying: playbackDelegate.state == .playing
        )
    }

    func updateLyricsView(
        track: MusicTrack?,
        lyrics: Lyrics?,
        elapsedTime: Double = 0,
        isPlaying: Bool = false
    ) {
        self.currentTrack = track
        self.currentLyrics = lyrics
        self.currentElapsedTime = elapsedTime
        self.isPlaying = isPlaying

        if lyricsView == nil {
            setupLyricsView()
        }

        DispatchQueue.main.async { [weak self] in
            let newLyricsView = self?.createLyricsView(
                track: track,
                lyrics: lyrics,
                elapsedTime: elapsedTime,
                isPlaying: isPlaying
            )

            if let newLyricsView {
                self?.lyricsView = newLyricsView
                self?.hostingView?.rootView = newLyricsView
            }
        }
    }

    // MARK: - Notification Handlers

    private func trackInfoRefresh() {
        print("LyricsWindowController: Track info refresh")
    }

    private func trackTransitioned(_ notif: TrackTransitionNotification) {
        print("LyricsWindowController: Track transitioned")
        update(track: notif.endTrack)
    }

    private func trackInfoUpdated(_ notif: TrackInfoUpdatedNotification) {
        print("LyricsWindowController: Track info updated")
    }

    /// Handle play or pause event.
    private func playbackStateChanged() {
        print("LyricsWindowController: Playback state changed")
        update()
    }

    private func seekPerformed() {
        print("LyricsWindowController: Seek performed")
        update()
    }
}

extension Track {
    var musicTrack: MusicTrack {
        MusicTrack(id: title ?? "", title: title, album: album, artist: artist, duration: duration)
    }
}
