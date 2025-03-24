//
// SampleModel.swift
// Camera Photos SwiftData
//
// Created by MANAS VIJAYWARGIYA on 23/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftData
import UIKit

@Model
class SampleModel {
  var name: String
  var data: Data?
  
  init(name: String, data: Data? = nil) {
    self.name = name
    self.data = data
  }
  
  var image: UIImage? {
    if let data {
      return UIImage(data: data)
    } else {
      return nil
    }
  }
}
