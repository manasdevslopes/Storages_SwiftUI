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
  var summary: String
  var rating: Int?
  var status: Status.RawValue
  
  init(
    title: String,
    author: String,
    dateAdded: Date = .now,
    dateStarted: Date = .distantPast,
    dateCompleted: Date = .distantPast,
    summary: String = "",
    rating: Int? = nil,
    status: Status = .onShelf
  ) {
    self.title = title
    self.author = author
    self.dateAdded = dateAdded
    self.dateStarted = dateStarted
    self.dateCompleted = dateCompleted
    self.summary = summary
    self.rating = rating
    self.status = status.rawValue
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
