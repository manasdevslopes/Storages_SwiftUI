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


// For iCloud CloudKit -
/*
 1. Must belong to Apple Developer Program
 2. Then select Team & Bundle ID of Apple Developer account in Signing & Capabilities.
 3. CLick on + icon Capability & search iCloud and add it to ur project by double click on it.
 4. Then copy the Bundle ID and then select CloudKit in iCloud section. In Containers, it will automatically be created otherwise do it manually. For manual, first click on + button in iCloud section.
 5. Second, Add a new Container like this (in the same pattern) -
    iCloud.your_bundle_id_that_u_copied_in_previous_state.
 6. It will create new container if it doesn't exists. Now it will create App's Entitlements
 7. Also if this - iCloud.your_bundle_id_that_u_copied_in_previous_state is in red , try clicking refresh icon, so that it will get refreshed and become white.
 8. For background refreshes, add this also "Background Modes" from Capability. Then checkmark Remote notifications in "Background Modes".
 9. To verify this go to developer.apple.com/account and login. Then Click on identifiers, & search for the ID that u have used. Double click on it -> Scroll down in Capability Section, and check "iCloud" & "Push notification" is enabled or not.
 10. Now go to Books Model -
     a. title and author are non-optional so give empty string"" to both. Means give default values to all properties which are non-optional.
     b. Same for dates as Date.now or Date.distantPast and same for other properties etc.
     c. All Relationships properties must be optional. That we already done that.
     d. CloudKit can't work with unique attribute and this may be problematic in some of ur application if you want to ensure that some properties are unique. If that's the case you'll have to do your check in code before you add or update records.
 11. Same follow in other Models as well.
 12. That's all we need to establish CloudKit in our App. Also data was added before enabling CloudKit, those will not sync in iCloud.
 
 Note: - In the iCloud section in Signing & Capibility on Xcode, there is a button CloudKit COnsole that will take us to Cloudkit Database Link. We can check CloudKit Database with all the containers. Check the one that u added recently.
 You can create Indexes in the Cloudkit Database Link and Also click on Deploy Schema Changes to Production. Click on Deploy, if u agree. Then ur app is ready for distribution & submission to the Apps Store.
 */
