//
//  File.swift
//  Aural
//
//  Created by tisfeng on 2024/12/21.
//  Copyright © 2024 Kartik Venugopal. All rights reserved.
//

import Foundation
import SwiftUI
import LyricsUI
import MusicPlayer

private var windows: [String: NSWindow] = [:]

/// Shows a window with the specified title and content.
public func showWindow<Content: View>(
    title: String,
    width: CGFloat = 700,
    height: CGFloat = 600,
    resizable: Bool = true,
    @ViewBuilder content: () -> Content
) {
    if let window = windows[title] {
        window.makeKeyAndOrderFront(nil)
    } else {
        var styleMask: NSWindow.StyleMask = [.titled, .closable]
        if resizable {
            styleMask.insert(.resizable)
        }

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: width, height: height),
            styleMask: styleMask,
            backing: .buffered,
            defer: false
        )

        window.title = NSLocalizedString(title, comment: "")
        window.titlebarAppearsTransparent = true
        window.isReleasedWhenClosed = false
        window.center()

        let wrappedContent = content()
            .frame(
                minWidth: width, maxWidth: .infinity,
                minHeight: height, maxHeight: .infinity
            )

        window.contentView = NSHostingView(rootView: wrappedContent)
        window.makeKeyAndOrderFront(nil)
        windows[title] = window
    }
}
