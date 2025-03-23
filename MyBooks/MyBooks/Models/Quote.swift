//
// Quote.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 21/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI
import SwiftData

@Model
class Quote {
  var creationDate: Date = Date.now
  var text: String = ""
  var page: String?
  
  init(text: String, page: String? = nil) {
    self.text = text
    self.page = page
  }
  
  var book: Book?
}
