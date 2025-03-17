//
// DownsizedImagesApp.swift
// DownsizedImages
//
// Created by MANAS VIJAYWARGIYA on 17/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

@main
struct DownsizedImagesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .modelContainer(for: Cache.self)
        }
    }
}
