//
// BookListView.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 19/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import SwiftData

enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
  case status = "status", title = "title", author = "author"
  
  var id: Self { self }
}

struct BookListView: View {
  
  @State private var createNewBook: Bool = false
  @State private var sortOrder: SortOrder = .status
  @State private var filter: String = ""
  
  var body: some View {
    NavigationStack {
      Picker("", selection: $sortOrder) {
        ForEach(SortOrder.allCases) { sortOrder in
          Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
        }
      }
      .buttonStyle(.bordered)
      
      BookList(sortOrder: sortOrder, filterString: filter)
        .searchable(text: $filter, prompt: Text("Filter on title or author"))
        .navigationTitle("My Books")
        .toolbar {
          Button {
            createNewBook = true
          } label: {
            Image(systemName: "plus.circle.fill").imageScale(.large)
          }
        }
        .sheet(isPresented: $createNewBook) {
          NewBookView()
            .presentationDetents([.medium])
        }
    }
  }
}

#Preview {
  let preview = Preview(Book.self)
  let books = Book.sampleBooks
  preview.addExamples(books)
  return BookListView()
  // .modelContainer(for: Book.self, inMemory: true)
    .modelContainer(preview.container)
}
