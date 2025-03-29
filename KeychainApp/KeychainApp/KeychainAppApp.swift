//
// KeychainAppApp.swift
// KeychainApp
//
// Created by MANAS VIJAYWARGIYA on 29/03/25.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//
    

import SwiftUI

/* In SwiftUI, when we save data in Keychain then it will sync with other devices if using the same apple ID by enabling iCloud in capabilities in the Xcode's project */
@main
struct KeychainAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
