//
// MyBooksApp.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 19/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
  var body: some Scene {
    WindowGroup {
      BookListView()
    }
    // Create a Container to persist the data
    .modelContainer(for: Book.self) // Access the modelContainer and whatever we want to store
  }
  
  init() {
    // To check the location of the Persistence Data
    print(URL.applicationSupportDirectory.path(percentEncoded: false))
  }
}
