//
// BookList.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 20/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import SwiftData

struct BookList: View {
  @Environment(\.modelContext) private var context
  // @Query(sort: \Book.title, order: .forward) private var books: [Book]
  @Query private var books: [Book]
  init(sortOrder: SortOrder, filterString: String) {
    let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
      case .status:
        [SortDescriptor(\.status), SortDescriptor(\.title)]
      case .title:
        [SortDescriptor(\.title)]
      case .author:
        [SortDescriptor(\.author)]
    }
    // Filter - by creating #Predicate (Macros)
    let predicate = #Predicate<Book> { book in
      book.title.localizedStandardContains(filterString) || book.author.localizedStandardContains(filterString)
      || filterString.isEmpty // Return every book when filterString empty
    }
    // Combine both Sort & Filter in a Query
    _books = Query(filter: predicate, sort: sortDescriptors)
  }
  
  var body: some View {
    Group {
      if books.isEmpty {
        ContentUnavailableView("Enter you first book", systemImage: "book.fill")
      } else {
        List {
          ForEach(books) { book in
            NavigationLink {
              EditBookView(book: book)
            } label: {
              HStack(spacing: 10) {
                book.icon
                VStack {
                  VStack(alignment: .leading) {
                    Text(book.title).font(.title2)
                    Text(book.author).foregroundStyle(.secondary)
                    if let rating = book.rating {
                      HStack {
                        ForEach(1..<rating, id: \.self) {_ in
                          Image(systemName: "star.fill").imageScale(.small).foregroundStyle(.yellow)
                        }
                      }
                    }
                    if let genres = book.genres {
                      ViewThatFits {
                        GenresStackView(genres: genres)
                        ScrollView(.horizontal, showsIndicators: false) {
                          GenresStackView(genres: genres)
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          .onDelete { indexSet in
            indexSet.forEach { index in
              let book = books[index]
              context.delete(book)
              try? context.save()
            }
          }
        }
        .listStyle(.plain)
      }
    }
  }
}

#Preview {
  let preview = Preview(Book.self)
  let books = Book.sampleBooks
  preview.addExamples(books)
  return NavigationStack {
    BookList(sortOrder: SortOrder.title, filterString: "")
  }
  .modelContainer(preview.container)
}
