//
// KeychainManager.swift
// KeychainApp
//
// Created by MANAS VIJAYWARGIYA on 29/03/25.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//
    

import SwiftUI
import Security

protocol KeychainManagerType {
  static func storeCredentialInKeychain(email: String, password: String)
  static func getPasswordFromKeychain(using email: String) -> String?
  static func deletePasswordFromKeychain(using email: String)
}

class KeychainManager: KeychainManagerType {
  private static var bundleID: String {
    return Bundle.main.bundleIdentifier ?? "com.blacenova.KeychainApp"
  }
  
  // MARK: - Saving / Updating Keychain Values
  static func storeCredentialInKeychain(email: String, password: String) {
    if let passwordData = password.data(using: .utf8) {
      let query = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: bundleID,
        kSecAttrAccount as String: email,
        kSecValueData as String: passwordData
      ] as CFDictionary
      
      // Adding Date to Keychain
      let status = SecItemAdd(query, nil)
      
      switch status {
        case errSecSuccess: print("Success") // Success
        case errSecDuplicateItem:
          // Update
          let updateQuery = [
            kSecAttrAccount: email,
            kSecAttrService: bundleID,
            kSecClass: kSecClassGenericPassword
          ] as CFDictionary
          
          let updateAttr = [kSecValueData: passwordData] as CFDictionary
          SecItemUpdate(updateQuery, updateAttr)
          
          // Other wise Error
        default: print("Error : \(status)")
      }
    }
  }
  
  // MARK: - Fetch Data form Keychain
  static func getPasswordFromKeychain(using email: String) -> String? {
    var password: String?
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: bundleID,
      kSecAttrAccount: email,
      kSecReturnData: kCFBooleanTrue!,
      kSecMatchLimit: kSecMatchLimitOne
    ] as CFDictionary
    
    // To copy the data
    var result: AnyObject?
    let status = SecItemCopyMatching(query, &result)
    
    if status == errSecSuccess, let data = result as? Data {
      password = String(data: data, encoding: .utf8)
    }
    return password
  }
  
  // MARK: - Delete from Keychain
  static func deletePasswordFromKeychain(using email: String) {
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: bundleID,
      kSecAttrAccount: email
    ] as CFDictionary
    
    _ = SecItemDelete(query)
  }
}
