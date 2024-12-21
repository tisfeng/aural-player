//
//  LyricsScrollView.swift
//  Aural
//
//  Created by tisfeng on 2024/12/2.
//  Copyright © 2024 Kartik Venugopal. All rights reserved.
//

import ComposableArchitecture
import LyricsCore
import LyricsUI
import LyricsXCore
import MusicPlayer
import SwiftUI

struct LyricsScrollView: View {

    var track: MusicTrack?
    var lyrics: Lyrics?
    var elapsedTime: TimeInterval
    var isPlaying: Bool
    let onLyricsTap: ((Int, ScrollViewProxy) -> Void)?
    let onLyricsUpdate: ((Lyrics) -> Void)?

    public var viewStore: ViewStore<LyricsXCoreState, LyricsXCoreAction>?

    @State private var isAutoScrollEnabled = true

    init(
        track: MusicTrack? = nil,
        lyrics: Lyrics? = nil,
        elapsedTime: Double = 0,
        isPlaying: Bool = true,
        onLyricsTap: ((Int, ScrollViewProxy) -> Void)? = nil,
        onLyricsUpdate: ((Lyrics) -> Void)? = nil
    ) {
        self.track = track
        self.lyrics = lyrics
        self.elapsedTime = elapsedTime
        self.isPlaying = isPlaying
        self.onLyricsTap = onLyricsTap
        self.onLyricsUpdate = onLyricsUpdate
        self.viewStore = nil

        if let track, let lyrics {
            self.viewStore = createViewStore(
                track: track,
                lyrics: lyrics,
                elapsedTime: elapsedTime,
                isPlaying: isPlaying
            )
        }
    }

    var body: some View {
        Group {
            if let viewStore {
                if #available(macOS 13.0, *) {
                    LyricsView(isAutoScrollEnabled: $isAutoScrollEnabled) { index, proxy in
                        let position = self.lyrics?[index].position ?? 0
                        seekTo(position: position, isPlaying: isPlaying)

                        withAnimation(.easeInOut) {
                            proxy.scrollTo(index, anchor: .center)
                        }

                        onLyricsTap?(index, proxy)
                    }
                    .environmentObject(viewStore)
                    .padding(.horizontal)
                } else {
                    Text("Lyrics view not available on this version of macOS")
                }
            } else {
                Text("No lyrics available")
            }
        }
        .frame(minWidth: 300, minHeight: 300)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Rectangle().fill(Color.systemBackground))
        .contextMenu {
            Button(action: {
                showSearchLyricsWindow()
            }) {
                Label("Search Lyrics", systemImage: "magnifyingglass")
            }
        }
    }

    /// Seek to position.
    public func seekTo(position: TimeInterval, isPlaying: Bool) {
        let playbackState = createPlaybackState(elapsedTime: position, isPlaying: isPlaying)
        let progressingAction = LyricsProgressingAction.playbackStateUpdated(playbackState)
        viewStore?.send(.progressingAction(progressingAction))
    }

    /// Show search lyrics window
    func showSearchLyricsWindow() {
        let windowController = NSWindowController(window: nil)
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1000, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Search Lyrics"
        window.center()

        if #available(macOS 12.0, *) {
            let contentView = LyricsSearchView(track: track) { lyrics in
                self.onLyricsUpdate?(lyrics)
                windowController.close()
            }
            window.contentView = NSHostingView(rootView: contentView)
        }

        windowController.window = window
        windowController.showWindow(nil)
    }
}
