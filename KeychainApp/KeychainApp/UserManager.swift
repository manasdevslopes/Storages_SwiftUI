//
// UserManager.swift
// KeychainApp
//
// Created by MANAS VIJAYWARGIYA on 29/03/25.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//
    

import SwiftUI

class UserManager {
  static let shared = UserManager()
  
  private init() {}
  
  private let users: [User] = [
    User(email: "test@test.com", password: "test"),
    User(email: "user2@example.com", password: "abc"),
  ]
  
  func isValidUser(_ email: String, _ password: String) -> Bool {
    return users.contains(where: { $0.email == email && $0.password == password })
  }
}
