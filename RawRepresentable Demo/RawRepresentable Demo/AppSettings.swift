//
// AppSettings.swift
// RawRepresentable Demo
//
// Created by MANAS VIJAYWARGIYA on 17/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct AppSettings {
  var name = ""
  var allowNotifications = false
  var skillLevel: SkillLevel = .beginner
  
  init () { }
}

extension AppSettings: Codable {
  enum CodingKeys: CodingKey {
    case name
    case allowNotifications
    case skillLevel
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.allowNotifications = try container.decode(Bool.self, forKey: .allowNotifications)
    self.skillLevel = try container.decode(SkillLevel.self, forKey: .skillLevel)
  }
  
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.name, forKey: .name)
    try container.encode(self.allowNotifications, forKey: .allowNotifications)
    try container.encode(self.skillLevel, forKey: .skillLevel)
  }
}

extension AppSettings: RawRepresentable {
  var rawValue: String {
    guard let data = try? JSONEncoder().encode(self),
          let appSettingsString = String(data: data, encoding: .utf8)
    else { return "{}" }
    return appSettingsString
  }
  
  init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
    let appSettings = try? JSONDecoder().decode(AppSettings.self, from: data)
    else { return nil }
    self = appSettings
  }
}
