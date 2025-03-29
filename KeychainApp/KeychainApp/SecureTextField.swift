//
// SecureTextField.swift
// KeychainApp
//
// Created by MANAS VIJAYWARGIYA on 29/03/25.
// ------------------------------------------------------------------------
//
// ------------------------------------------------------------------------
//


import SwiftUI

struct SecureTextField: View {
  @Binding var externalText: String
  @State var text: String = ""
  var placeholder: String
  @State private var isSecured: Bool = true
  @FocusState private var isFocused: Bool // Tracks focus state
  var onCompletion: ((String) -> ())?
  
  var body: some View {
    Group {
      ZStack {
        TextField(placeholder, text: $text)
          .textContentType(.password).textInputAutocapitalization(.never)
          .keyboardType(.asciiCapable).autocorrectionDisabled()
          .opacity(isSecured ? 0 : 1).focused($isFocused)
        
        SecureField(placeholder, text: $text)
          .textContentType(.password)
          .textInputAutocapitalization(.never).keyboardType(.asciiCapable)
          .autocorrectionDisabled()
          .opacity(isSecured ? 1 : 0).focused($isFocused)
        
      }
    }
    .textFieldStyle(.roundedBorder)
    .overlay(alignment: .trailing) {
      Button {
        isSecured.toggle()
      } label: {
        Image(systemName: self.isSecured ? "eye" : "eye.slash")
      }
      .tint(.primary).padding(.trailing)
    }
    .onChange(of: text) { oldValue, newValue in
      if !newValue.isEmpty {
        onCompletion?(newValue)
      }
    }
    .onChange(of: externalText) { _, newValue in
      externalText = newValue
      text = newValue // Sync internal state with parent
    }
    .onAppear {
      text = externalText // Initialize internal state with parent value
    }
  }
}

#Preview {
  SecureTextField(externalText: .constant(""), placeholder: "Enter password")
}
