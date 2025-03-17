//
// SkillLevel.swift
// RawRepresentable Demo
//
// Created by MANAS VIJAYWARGIYA on 17/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

enum SkillLevel: String, Identifiable, CaseIterable, Codable {
  var id: Self { self }
  case beginner
  case novice
  case intermediate
  case advanced
  case expert
  case master
  case guru
}
