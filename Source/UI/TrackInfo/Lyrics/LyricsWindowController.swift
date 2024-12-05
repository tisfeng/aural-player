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

    private var currentTrack: MusicTrack?
    private var currentLyrics: Lyrics?
    private var currentElapsedTime: Double = 0
    private var isPlaying: Bool = true

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

        let hostingView = NSHostingView(rootView: LyricsScrollView())
        window.contentView = hostingView
        self.hostingView = hostingView

        messenger.subscribe(to: .Player.trackInfo_refresh, handler: trackInfoRefresh)

        messenger.subscribeAsync(to: .Player.trackTransitioned, handler: trackTransitioned)
        messenger.subscribeAsync(to: .Player.trackInfoUpdated, handler: trackInfoUpdated(_:))
        messenger.subscribeAsync(to: .Player.trackNotPlayed, handler: trackTransitioned)
        messenger.subscribeAsync(to: .Player.playbackStateChanged, handler: playbackStateChanged)
        messenger.subscribeAsync(to: .Player.seekPerformed, handler: seekPerformed)
        messenger.subscribeAsync(to: .Player.loopRestarted, handler: seekPerformed)

        update()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    convenience init(track: MusicTrack?, lyrics: Lyrics?) {
        self.init(window: nil)
        updateContent(track: track, lyrics: lyrics)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    }

    // MARK: Update UI ----------------------------------------------------------------------

    func update(track: Track? = nil, elapsedTime: Double = 0) {
        let playingTrack = track ?? playbackDelegate.playingTrack
        let lyrics = Lyrics(playingTrack?.lyrics ?? "")

        let elapsedTime = elapsedTime > 0 ? elapsedTime : playbackDelegate.seekPosition.timeElapsed

        updateContent(
            track: playingTrack?.musicTrack,
            lyrics: lyrics,
            elapsedTime: elapsedTime,
            isPlaying: playbackDelegate.state == .playing
        )
    }

    func updateContent(
        track: MusicTrack?, lyrics: Lyrics?, elapsedTime: Double = 0, isPlaying: Bool = true
    ) {
        self.currentTrack = track
        self.currentLyrics = lyrics
        self.currentElapsedTime = elapsedTime
        self.isPlaying = isPlaying

        DispatchQueue.main.async { [self] in
            if let window = self.window {
                let lyricsView = LyricsScrollView(
                    track: track,
                    lyrics: lyrics,
                    elapsedTime: elapsedTime,
                    isPlaying: isPlaying
                ) { position in
                    print("Seeking to position \(position)")
                    playbackDelegate.seekToTime(position)
                }

                window.contentView = NSHostingView(rootView: lyricsView)
            }
        }
    }

    // MARK: Notification handling --------------------------------------------------------

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
    /// Convert Track to MusicTrack
    var musicTrack: MusicTrack {
        MusicTrack(id: title ?? "", title: title, album: album, artist: artist, duration: duration)
    }
}
