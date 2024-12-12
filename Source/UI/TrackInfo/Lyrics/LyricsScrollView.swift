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
    var elapsedTime: Double = 0
    var isPlaying = true
    public let onLyricsTap: ((Int, ScrollViewProxy) -> Void)?

    @State private var isAutoScrollEnabled = true
    public let viewStore: ViewStore<LyricsXCoreState, LyricsXCoreAction>?

    init(
        track: MusicTrack? = nil,
        lyrics: Lyrics? = nil,
        elapsedTime: Double = 0,
        isPlaying: Bool = true,
        onLyricsTap: ((Int, ScrollViewProxy) -> Void)? = nil
    ) {
        self.track = track
        self.lyrics = lyrics
        self.elapsedTime = elapsedTime
        self.isPlaying = isPlaying
        self.onLyricsTap = onLyricsTap

        if let track = track, let lyrics = lyrics {
            let coreState: LyricsXCoreState = {
                let playbackState: MusicPlayer.PlaybackState = isPlaying ? .playing(time: elapsedTime) : .paused(time: elapsedTime)
                let player = MusicPlayerState(
                    player: MusicPlayers.Virtual(track: track, state: playbackState))

                var searching = LyricsSearchingState(track: track)
                searching.currentLyrics = lyrics
                searching.searchResultSorted = [lyrics]
                if let title = track.title, let artist = track.artist {
                    searching.searchTerm = .info(title: title, artist: artist)
                }

                let progressing = LyricsProgressingState(lyrics: lyrics, playbackState: playbackState)

                return LyricsXCoreState(
                    playerState: player,
                    searchingState: searching,
                    progressingState: progressing
                )
            }()

            let store = Store(
                initialState: coreState,
                reducer: Reducer(LyricsProgressingState.reduce)
                    .optional()
                    .pullback(
                        state: \LyricsXCoreState.progressingState,
                        action: /LyricsXCoreAction.progressingAction,
                        environment: { $0 }),
                environment: .default)

            self.viewStore = ViewStore(store)

            seekTo(position: elapsedTime, isPlaying: isPlaying)
        } else {
            self.viewStore = nil
        }
    }

    var body: some View {
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
                .frame(minWidth: 300, minHeight: 300)
            } else {
               Text("Lyrics view not available on this version of macOS")
                    .frame(minWidth: 300, minHeight: 300)
            }
        } else {
            Text("No lyrics available")
                .frame(minWidth: 300, minHeight: 300)
        }
    }

    /// Seek to position.
    public func seekTo(position: TimeInterval, isPlaying: Bool) {
        let playbackState: MusicPlayer.PlaybackState = isPlaying ? .playing(time: position) : .paused(time: position)
        let progressingAction = LyricsProgressingAction.playbackStateUpdated(playbackState)
        viewStore?.send(.progressingAction(progressingAction))
    }
}

