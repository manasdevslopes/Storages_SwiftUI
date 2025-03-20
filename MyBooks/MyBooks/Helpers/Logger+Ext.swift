//
// Logger+Ext.swift
// MyBooks
//
// Created by MANAS VIJAYWARGIYA on 20/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation
import OSLog

extension Logger {
  static let subsystem = Bundle.main.bundleIdentifier!
  static let fileLocation = Logger(subsystem: subsystem, category: "FileLocation")
  static let dataStore = Logger(subsystem: subsystem, category: "dataStore")
  static let fileManager = Logger(subsystem: subsystem, category: "fileManager")
}
