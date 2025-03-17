//
// ContentView.swift
// RawRepresentable Demo
//
// Created by MANAS VIJAYWARGIYA on 17/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  // @AppStorage("name") var name = ""
  // @AppStorage("allowNotifications") var allowNotifications = false
  // @AppStorage("skillLevel") var skillLevel: SkillLevel = .beginner
  @AppStorage("appSettings") var appSettings = AppSettings()
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $appSettings.name).textFieldStyle(.roundedBorder)
        Toggle("Allow Notifications", isOn: $appSettings.allowNotifications)
        Picker("Skill Level", selection: $appSettings.skillLevel) {
          ForEach(SkillLevel.allCases) { skillLevel in
            Text(skillLevel.rawValue.capitalized)
          }
        }
      }
      .navigationTitle("Settings")
    }
  }
}

#Preview {
  ContentView()
}
