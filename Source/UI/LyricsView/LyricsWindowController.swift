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

    private var hostingView: NSHostingView<LyricsWrappedView>?
    private var lyricsView: LyricsWrappedView?

    private var track: Track?
    private var lyrics: Lyrics?
    private var elapsedTime: Double = 0
    private var isPlaying: Bool = false

    lazy var messenger = Messenger(for: self)

    fileprivate lazy var theDelegate: SnappingWindowDelegate = {
        SnappingWindowDelegate(window: self.window! as! SnappingWindow)
    }()

    override init(window: NSWindow?) {
        let window = SnappingWindow(
            contentRect: NSRect(x: 0, y: 0, width: lyricsWidth, height: lyricsHeight),
            styleMask: [.resizable],
            backing: .buffered,
            defer: false
        )
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.identifier = .init(rawValue: WindowID.lyrics.rawValue)
        window.center()

        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true

        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = false
        window.isMovableByWindowBackground = true

        super.init(window: window)

        window.delegate = theDelegate

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
        let lyricsView = LyricsWrappedView(
            track: track?.musicTrack,
            lyrics: lyrics,
            elapsedTime: elapsedTime,
            isPlaying: isPlaying,
            onLyricsTap: { [weak self] index, proxy in
                let position = self?.lyrics?[index].position ?? 0
                self?.messenger.publish(.Player.jumpToTime, payload: position)
            },
            onLyricsUpdate: { [weak self] lyrics in
                if let fileName = self?.track?.fileName {
                    lyrics.persistToFile(fileName)
                }
                self?.updateTrackInfo()
            }
        )

        self.lyricsView = lyricsView

        if hostingView == nil {
            hostingView = NSHostingView(rootView: lyricsView)
            hostingView?.wantsLayer = true
            hostingView?.layer?.cornerRadius = playerUIState.cornerRadius
            hostingView?.layer?.masksToBounds = true
            hostingView?.layer?.backgroundColor = systemColorScheme.backgroundColor.cgColor
            hostingView?.appearance = .init(named: .aqua)
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
        lyrics = track?.fetchLyrics()
        updatePlaybackState()

        DispatchQueue.main.async {
            self.updateLyricsView()
        }
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
