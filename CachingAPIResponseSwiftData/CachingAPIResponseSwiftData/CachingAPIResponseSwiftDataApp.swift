//
// CachingAPIResponseSwiftDataApp.swift
// CachingAPIResponseSwiftData
//
// Created by MANAS VIJAYWARGIYA on 25/03/25.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//
    

import SwiftUI
import SwiftData

@main
struct CachingAPIResponseSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView().modelContainer(for: [Photo.self])
        }
    }
}

/*
 Tutorial - Discover How To Save Your API Response Into SwiftData ☁️ | SwiftData Tutorial | #7 - tundsdev - https://www.youtube.com/watch?v=4uf6kVkyJfs
 */
