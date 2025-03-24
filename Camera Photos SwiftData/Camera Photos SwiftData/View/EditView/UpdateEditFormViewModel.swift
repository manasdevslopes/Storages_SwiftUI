//
// UpdateEditFormViewModel.swift
// Camera Photos SwiftData
//
// Created by MANAS VIJAYWARGIYA on 24/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

@Observable
class UpdateEditFormViewModel {
  var name: String = ""
  var data: Data?
  
  var sample: SampleModel?
  var cameraImage: UIImage?
  
  var image: UIImage {
    if let data, let uiImage = UIImage(data: data) {
      return uiImage
    } else {
      return Constants.placeholder
    }
  }
  
  init() { }
  init(sample: SampleModel) {
    self.sample = sample
    self.name = sample.name
    self.data = sample.data
  }
  
  @MainActor
  func clearImage() {
    data = nil
  }
  
  var isUpDating: Bool { sample != nil }
  var isDisabled: Bool { name.isEmpty }
}
