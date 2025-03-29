//
// ContentView.swift
// KeychainApp
//
// Created by MANAS VIJAYWARGIYA on 29/03/25.
// ------------------------------------------------------------------------
//
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var shouldStoreCredentials: Bool = false
  @State private var isLoggedIn: Bool = false
  @State private var isLoggedInAttempted: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        TextField("Email", text: $email,
//                  , onEditingChanged: { _ in
//          password = KeychainManager.getPasswordFromKeychain(using: email) ?? ""
//        })
        onCommit: {
          password = KeychainManager.getPasswordFromKeychain(using: email) ?? ""
        })
          .textInputAutocapitalization(.never).keyboardType(.asciiCapable).autocorrectionDisabled()
          .textFieldStyle(.roundedBorder)
          
        SecureTextField(externalText: $password, placeholder: "Enter Password") { text in
          password = text
        }

        Toggle("Store Credentials", isOn: $shouldStoreCredentials).toggleStyle(.switch)
        
        HStack {
          Button(role: .destructive) {
            KeychainManager.deletePasswordFromKeychain(using: email)
            self.email = ""
            self.password = ""
          } label: {
            Text("Delete Credentials")
          }
          .buttonStyle(.borderedProminent).disabled(email.isEmpty || password.isEmpty)
        }
        .frame(maxWidth: .infinity, alignment: .trailing).padding(.top, 40)
        
        Spacer()
        
        if isLoggedIn {
          Text("User Logged In successfully").padding(.bottom, 50)
        } else if !isLoggedIn && isLoggedInAttempted {
          Text("Invalid email or password").padding(.bottom, 50)
        }
        
        Button {
          isLoggedInAttempted = true
          isLoggedIn = isValidCredentials()
          if isLoggedIn && shouldStoreCredentials {
            KeychainManager.storeCredentialInKeychain(email: email, password: password)
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            isLoggedInAttempted = false
            isLoggedIn = false
          }
        } label: {
          Text("Log In")
        }
        .buttonStyle(.borderedProminent).disabled(email.isEmpty || password.isEmpty)
      }
      .padding()
      .navigationTitle("Keychain Demo")
    }
  }
}

extension ContentView {
  private func isValidCredentials() -> Bool {
    return UserManager.shared.isValidUser(email, password)
  }
}
#Preview {
  ContentView()
}
