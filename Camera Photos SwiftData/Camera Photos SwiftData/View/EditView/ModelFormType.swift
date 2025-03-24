//
// ModelFormType.swift
// Camera Photos SwiftData
//
// Created by MANAS VIJAYWARGIYA on 24/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

enum ModelFormType: Identifiable, View {
  case new
  case update(SampleModel)
  var id: String {
    String(describing: self)
  }
  
  var body: some View {
    switch self {
      case .new:
        UpdateEditFormView(vm: UpdateEditFormViewModel())
      case .update(let sampleModel):
        UpdateEditFormView(vm: UpdateEditFormViewModel(sample: sampleModel))
    }
  }
}
