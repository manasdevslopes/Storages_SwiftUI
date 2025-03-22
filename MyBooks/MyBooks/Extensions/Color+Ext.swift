//
// Color+Ext.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 22/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

extension Color {
  
  init?(hex: String) {
    guard let uiColor = UIColor(hex: hex) else { return nil }
    self.init(uiColor: uiColor)
  }
  
  func toHexString(includeAlpha: Bool = false) -> String? {
    return UIColor(self).toHexString(includeAlpha: includeAlpha)
  }
  
}
