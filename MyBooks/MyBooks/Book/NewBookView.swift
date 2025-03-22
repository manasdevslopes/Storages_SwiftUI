//
// NewBookView.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 19/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//

/*
 SwiftData stores all of the data in memory and the information is not persisted to the database until necessary, for example creation, updates or deletes.
 These operations are all managed by the container's main **context**. So when we created our container, it creates that context & places it in environment where I can access it with the model context key path (environment)
 
 */
import SwiftUI

struct NewBookView: View {
  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) var dismiss
  @State private var title: String = ""
  @State private var author: String = ""
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Book Title", text: $title)
        TextField("Author", text: $author)
        Button("Create") {
          let newBook = Book(title: title, author: author)
          context.insert(newBook)
          try? context.save()
          dismiss()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .buttonStyle(.borderedProminent).padding(.vertical)
        .disabled(title.isEmpty || author.isEmpty)
        .navigationTitle("New Book").navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Button("Cancel") {
              dismiss()
            }
          }
        }
      }
    }
  }
}

#Preview {
  NewBookView()
}
