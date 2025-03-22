//
// Genre.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 22/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI
import SwiftData

@Model
class Genre {
  var name: String
  var color: String
  var books: [Book]?
  
  init(name: String, color: String) {
    self.name = name
    self.color = color
  }
  
  var hexColor: Color {
    Color(hex: self.color) ?? .red
  }
}
