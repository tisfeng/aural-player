//
//  MenuBarAppModeController.swift
//  Aural
//
//  Copyright © 2024 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

///
/// Controller responsible for presenting / dismissing the *Menu Bar* application user interface mode.
///
/// The menu bar app mode's interace consists of a menu that drops down from the macOS menu bar.
/// The menu item that is displayed presents a view containing essential player controls and some basic
/// options to customize that view.
///
/// The menu bar app mode allows the user access to essential player functions and is intended for a
/// low level of user interaction. It will typically be used when running the application in the "background".
///
class MenuBarAppModeController: NSObject, AppModeController {

    var mode: AppMode {.menuBar}
    
    var windowMagnetism: Bool = false
    
    var isShowingPlayer: Bool {true}
    
    var isShowingPlayQueue: Bool {true}

    var isShowingLyrics: Bool { true }

    var isShowingEffects: Bool {true}
    
    var isShowingChaptersList: Bool {true}
    
    var isShowingVisualizer: Bool {false}
    
    var isShowingWaveform: Bool {false}
    
    var isShowingTrackInfo: Bool {true}

    private var statusItem: NSStatusItem?
    private var rootMenu: NSMenu!
    
    private var playerViewController: MenuBarPlayerViewController!
    private lazy var playQueueViewController: MenuBarPlayQueueViewController! = .init()
    private let settingsViewController: MenuBarSettingsViewController! = .init()
    
    private var playQueueMenuItem: NSMenuItem!
    private var settingsMenuItem: NSMenuItem!
    
    private let appIcon: NSImage = NSImage(named: "AppIcon-MenuBar")!
    
    private lazy var messenger: Messenger = .init(for: self)
    
    override init() {
        
        super.init()
        
        messenger.subscribe(to: .MenuBarPlayer.togglePlayQueue, handler: showOrHidePlayQueue)
        messenger.subscribe(to: .MenuBarPlayer.toggleSettingsMenu, handler: toggleSettingsMenu)
    }
    
    func presentMode(transitioningFromMode previousMode: AppMode?) {
        
        playerViewController = MenuBarPlayerViewController()

        // Make app run in menu bar and make it active.
        NSApp.setActivationPolicy(.accessory)
        NSApp.activate(ignoringOtherApps: true)
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        statusItem?.button?.image = appIcon
        statusItem?.button?.toolTip = "Aural Player v\(NSApp.appVersion)"
        
        rootMenu = NSMenu()
        statusItem?.menu = rootMenu
        
        let playerMenuItem = NSMenuItem(view: playerViewController.view)
        rootMenu.addItem(playerMenuItem)
        
        showOrHidePlayQueue()
        
        if #available(macOS 14, *) {
            
            createSettingsMenu()
            settingsMenuItem.hide()
        }
        
        rootMenu.delegate = self
    }

    private func createSettingsMenu() {
        
        settingsMenuItem = NSMenuItem(view: settingsViewController.view)
        
        rootMenu.addItem(.separator())
        rootMenu.addItem(settingsMenuItem)
    }
    
    func dismissMode() {
        
        playerViewController?.destroy()
        playQueueViewController?.destroy()
     
        if let statusItem = self.statusItem {
            
            statusItem.menu?.cancelTracking()
            statusItem.menu = nil
            rootMenu = nil
            
            NSStatusBar.system.removeStatusItem(statusItem)
            self.statusItem = nil
        }
        
        playerViewController = nil
        playQueueViewController = nil
        playQueueMenuItem = nil
        settingsMenuItem = nil
    }
    
    private func toggleSettingsMenu() {
        
        if #available(macOS 14, *) {
            
            if settingsMenuItem.isHidden {
                settingsViewController.prepareToShow()
            }
            
            settingsMenuItem.toggleShownOrHidden()
            
        } else {
            
            // Older systems
            if settingsMenuItem == nil {
                createSettingsMenu()
                
            } else if let theSettingsMenuItem = self.settingsMenuItem {
                
                rootMenu.removeItem(theSettingsMenuItem)
                self.settingsMenuItem = nil
            }
        }
    }
    
    private func showOrHidePlayQueue() {
        
        if #available(macOS 14, *) {
            
            if menuBarPlayerUIState.showPlayQueue, playQueueMenuItem == nil {
                createPlayQueueMenuItem()
            }
            
            playQueueMenuItem?.showIf(menuBarPlayerUIState.showPlayQueue)
            
        } else {
            
            if menuBarPlayerUIState.showPlayQueue {
                
                if playQueueMenuItem == nil {
                    createPlayQueueMenuItem()
                }
                
            } else if let thePlayQueueMenuItem = self.playQueueMenuItem {
                
                rootMenu.removeItem(thePlayQueueMenuItem)
                self.playQueueMenuItem = nil
            }
        }
    }
    
    private func createPlayQueueMenuItem() {
        
        rootMenu.insertItem(.separator(), at: 1)
        
        if playQueueViewController == nil {
            playQueueViewController = .init()
        }
        
        self.playQueueMenuItem = NSMenuItem(view: playQueueViewController.view)
        rootMenu.insertItem(playQueueMenuItem, at: 2)
    }
}

extension MenuBarAppModeController: NSMenuDelegate {
    
    func menuDidClose(_ menu: NSMenu) {
        messenger.publish(.MenuBarPlayer.menuDidClose)
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        messenger.publish(.MenuBarPlayer.menuWillOpen)
    }
}
