//
// SampleView.swift
// Camera Photos SwiftData
//
// Created by MANAS VIJAYWARGIYA on 24/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import SwiftData

struct SampleView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  @State private var formType: ModelFormType?
  let sample: SampleModel
  
  var body: some View {
    VStack {
      Text(sample.name).font(.largeTitle)
      ZoomableScrollView {
        Image(uiImage: sample.image == nil ? Constants.placeholder : sample.image!)
          .resizable().scaledToFit()
          .clipShape(RoundedRectangle(cornerRadius: 12)).padding()
      }
      HStack {
        Button("Edit") {
          formType = .update(sample)
        }
        .sheet(item: $formType) { $0 }
        Button("Delete", role: .destructive) {
          modelContext.delete(sample)
          try? modelContext.save()
          dismiss()
        }
      }
      .buttonStyle(.borderedProminent).frame(maxWidth: .infinity, alignment: .trailing)
      Spacer()
    }
    .padding().navigationTitle("Sample View").navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  let preview = Preview(SampleModel.self)
  return NavigationStack {
    SampleView(sample: SampleModel.sample[1])
  }
  .modelContainer(preview.container)
}
