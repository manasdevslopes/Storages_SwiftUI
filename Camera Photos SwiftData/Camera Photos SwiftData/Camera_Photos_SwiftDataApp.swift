//
// Camera_Photos_SwiftDataApp.swift
// Camera Photos SwiftData
//
// Created by MANAS VIJAYWARGIYA on 23/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import SwiftData

@main
struct Camera_Photos_SwiftDataApp: App {
  let container: ModelContainer
  
  var body: some Scene {
    WindowGroup {
      PhotosListView()
    }
    .modelContainer(container)
  }
  
  init() {
    let schema = Schema([SampleModel.self])
    let config = ModelConfiguration("CameraPhotosSwiftUI", schema: schema)
    do {
      container = try ModelContainer(for: schema, configurations: config)
      print("Successfully configured the container")
    } catch {
      fatalError("Couldn't configure the container")
    }
    print("By Default ModelContainer stores here (applicationSupportDirectory) - \(URL.applicationSupportDirectory.path(percentEncoded: false))")
  }
}
