//
// AppState.swift
// SceneStorageDemo
//
// Created by MANAS VIJAYWARGIYA on 17/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct AppState {
  var sortOrder: SortOrder = .asc
  var selectedTab: Int = 0
}

extension AppState: Codable {
  enum CodingKeys: CodingKey {
    case sortOrder
    case selectedTab
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.sortOrder = try container.decode(SortOrder.self, forKey: .sortOrder)
    self.selectedTab = try container.decode(Int.self, forKey: .selectedTab)
  }
  
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.sortOrder, forKey: .sortOrder)
    try container.encode(self.selectedTab, forKey: .selectedTab)
  }
}

extension AppState: RawRepresentable {
  var rawValue: String {
    guard let data = try? JSONEncoder().encode(self),
          let appStateString = String(data: data, encoding: .utf8)
    else { return "{}" }
    return appStateString
  }
  
  init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
          let appState = try? JSONDecoder().decode(AppState.self, from: data)
    else { return nil }
    self = appState
  }
}
