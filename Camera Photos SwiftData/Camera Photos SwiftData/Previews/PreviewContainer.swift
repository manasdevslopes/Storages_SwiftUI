//
// PreviewContainer.swift
// Camera Photos SwiftData
//
// Created by MANAS VIJAYWARGIYA on 23/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI
import SwiftData

struct Preview {
  let container: ModelContainer
  
  init(_ models: any PersistentModel.Type...) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let schema = Schema(models)
    do {
      container = try ModelContainer(for: schema, configurations: config)
    } catch {
      fatalError("Couldn't create preview container")
    }
  }
  
  func addExamples(_ examples: [any PersistentModel]) {
    Task { @MainActor in
      examples.forEach { example in
        container.mainContext.insert(example)
      }
    }
  }
}
