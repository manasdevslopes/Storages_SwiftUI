//
// NewGenreView.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 22/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftData
import SwiftUI

struct NewGenreView: View {
  @State private var name = ""
  @State private var color = Color.red
  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("name", text: $name)
        ColorPicker("Set the genre color", selection: $color, supportsOpacity: false)
        Button("Create") {
          let newGenre = Genre(name: name, color: color.toHexString()!)
          context.insert(newGenre)
          try? context.save()
          dismiss()
        }
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .disabled(name.isEmpty)
      }
      .padding()
      .navigationTitle("New Genre")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  NewGenreView()
}
