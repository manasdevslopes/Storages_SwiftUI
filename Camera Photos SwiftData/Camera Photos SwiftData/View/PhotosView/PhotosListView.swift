//
// PhotosListView.swift
// Camera Photos SwiftData
//
// Created by MANAS VIJAYWARGIYA on 23/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import SwiftData

struct PhotosListView: View {
  @Query(sort: \SampleModel.name) var samples: [SampleModel]
  @Environment(\.modelContext) private var modelContext
  @State private var formType: ModelFormType?
  
  var body: some View {
    NavigationStack {
      Group {
        if samples.isEmpty {
          ContentUnavailableView("Add your first photo", systemImage: "photo")
        } else {
          List(samples) { sample in
            NavigationLink(value: sample) {
              HStack {
                Image(uiImage: sample.image == nil ? Constants.placeholder : sample.image!)
                  .resizable().scaledToFill()
                  .frame(width: 50, height: 50)
                  .clipShape(RoundedRectangle(cornerRadius: 12)).padding(.trailing)
                Text(sample.name).font(.title)
              }
            }
            .swipeActions(allowsFullSwipe: true) {
              Button(role: .destructive) {
                modelContext.delete(sample)
                try? modelContext.save()
              } label: {
                Image(systemName: "trash")
              }
            }
          }
          .listStyle(.plain)
        }
      }
      .navigationDestination(for: SampleModel.self) {sample in
        SampleView(sample: sample)
      }
      .navigationTitle("Picker or Camera")
      .toolbar {
        Button {
          formType = .new
        }label: {
          Image(systemName: "plus.circle.fill")
        }
        .sheet(item: $formType) { $0 }
      }
    }
  }
}

#Preview {
  let preview = Preview(SampleModel.self)
  let samples = SampleModel.sample
  preview.addExamples(samples)
  return NavigationStack {
    PhotosListView()
  }
  .modelContainer(preview.container)
}
