//
// GenresStackView.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 22/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct GenresStackView: View {
  var genres: [Genre]
    var body: some View {
      HStack {
        ForEach(genres.sorted(using: KeyPathComparator(\Genre.name))) { genre in
          Text(genre.name).font(.caption).foregroundStyle(.white).padding(5).background(RoundedRectangle(cornerRadius: 5).fill(genre.hexColor))
        }
      }
    }
}
