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
import OSLog

@main
struct MyBooksApp: App {
  let container: ModelContainer
  let logger = Logger.fileLocation
  
  var body: some Scene {
    WindowGroup {
      BookListView()
    }
    // Create a Container to persist the data
    // 1st way - Model Container Directly
    // .modelContainer(for: Book.self) //It uses Library ~ ApplicationSupports Diretory. Access the modelContainer and whatever we want to store
    .modelContainer(container)
  }
  
  init() {
    // 2nd way - To create ModelContainer to a different path along with its file path name
    // It uses Documents ~ MyBooks.store
    /*let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
    do {
      container = try ModelContainer(for: Book.self, configurations: config)
    } catch {
      fatalError("Couldn't configure the container")
    }
    // To check the location of the Persistence Data
    logger.info("\(URL.documentsDirectory.path())")
    */
    
    // 3rd way - It uses Library ~ ApplicationSupports Diretory. It also helps in migration part.
    // On the same applicationSupportsDirectory using Schema
    let schema = Schema([Book.self])
    let config = ModelConfiguration("MyBooks", schema: schema)
    do {
      container = try ModelContainer(for: schema, configurations: config)
    } catch {
      fatalError("Couldn't configure the container")
    }
    logger.info("By Default ModelContainer stores here (applicationSupportDirectory) - \(URL.applicationSupportDirectory.path(percentEncoded: false))")
  }
}

// In SwiftData, also like CoreData, it stores data by default in Application Support Directory for our App in the simulator.
