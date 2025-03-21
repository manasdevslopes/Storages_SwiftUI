//
// Book.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 19/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI
import SwiftData

// MARK: - Model for SwiftData Object Book
@Model
class Book {
  var title: String
  var author: String
  var dateAdded: Date
  var dateStarted: Date
  var dateCompleted: Date
  @Attribute(originalName: "summary") // Lightweight migration - When property name changes
  var synopsis: String
  var rating: Int?
  var status: Status.RawValue
  var recommendedBy: String = "" // Light weight Migration
  /*
   2 ways of Light weight migration -
   a. If it is reuired value, then do Lightweight migration when new property added with a value, so it is recommended to put that value, eg empty string ("") in property as well as in init().
   b. If the new property is optional eg, var recommendedBy: String?, then in init() give: recommendedBy: String? = nil. So there will be no crash.
  */
  
  init(
    title: String,
    author: String,
    dateAdded: Date = .now,
    dateStarted: Date = .distantPast,
    dateCompleted: Date = .distantPast,
    synopsis: String = "",
    rating: Int? = nil,
    status: Status = .onShelf,
    recommendedBy: String = "" // Lightweight migration when new property added with a value.
  ) {
    self.title = title
    self.author = author
    self.dateAdded = dateAdded
    self.dateStarted = dateStarted
    self.dateCompleted = dateCompleted
    self.synopsis = synopsis
    self.rating = rating
    self.status = status.rawValue
    self.recommendedBy = recommendedBy
  }
  
  var icon: Image {
    switch Status(rawValue: status)! {
      case .onShelf:
        Image(systemName: "checkmark.diamond.fill")
      case .inProgress:
        Image(systemName: "book.fill")
      case .completed:
        Image(systemName: "books.vertical.fill")
    }
  }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
  case onShelf, inProgress, completed
  var id: Self { self }
  var descr: String {
    switch self {
      case .onShelf:
        "On Shelf"
      case .inProgress:
        "In Progress"
      case .completed:
        "Completed"
    }
  }
}
