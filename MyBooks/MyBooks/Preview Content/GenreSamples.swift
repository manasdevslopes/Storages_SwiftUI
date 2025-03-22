//
// GenreSamples.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 22/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation

extension Genre {
  static var sampleGenres: [Genre] {
    [
      Genre(name: "Fiction", color: "00FF00"),
      Genre(name: "Non Fiction", color: "0000FF"),
      Genre(name: "Romance", color: "FF0000"),
      Genre(name: "Thriller", color: "000000")
    ]
  }
}
