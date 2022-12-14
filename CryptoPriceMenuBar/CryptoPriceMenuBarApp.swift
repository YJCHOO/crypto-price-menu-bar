//
//  CryptoPriceMenuBarApp.swift
//  CryptoPriceMenuBar
//
//  Created by Juan on 23/08/2022.
//

import SwiftUI

@main
struct CryptoPriceMenuBarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: CryptoListViewModel())
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate,ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    private var cryptoListVM: CryptoListViewModel!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        
        self.cryptoListVM = CryptoListViewModel()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "chart.line.uptrend.xyaxis.circle", accessibilityDescription: "Chart Line")
            statusButton.action = #selector(togglePopover)
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 300)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView(vm: self.cryptoListVM))
    }
    
    @objc func togglePopover() {
        
        Task {
            await self.cryptoListVM.populateCryptos(cryptoNames: Constants.Cryptos.selectedCrypto())
        }
        
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button
                             , preferredEdge:NSRectEdge.minY)
            }
        }
    }
}
