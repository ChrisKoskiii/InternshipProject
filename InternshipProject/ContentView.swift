//
//  ContentView.swift
//  InternshipProject
//
//  Created by Christopher Koski on 10/5/22.
//

import SwiftUI

enum ValidationMessage {
  case firstMessage
  case invalidPassword
  case invalidUsername
  case validCredentials
}

struct ContentView: View {
  
  @State private var username: String = ""
  @State private var password1: String = ""
  @State private var password2: String = ""
  
  @State private var validUsername = false
  @State private var validPassword = false
  
  @State private var validationMessage: ValidationMessage = .firstMessage
  
  var body: some View {
    VStack {
      Text("Welcome!")
        .font(.title)
        .fontWeight(.bold)
      VStack {
        TextField("Username", text: $username)
        SecureField("Password", text: $password1)
        
        SecureField("Confirm Password", text: $password2)
      }
      
      Button {
        checkCredentials()
        
        if validUsername && validPassword {
          validationMessage = .validCredentials
        } else if !validPassword {
          validationMessage = .invalidPassword
        } else if !validUsername {
          validationMessage = .invalidUsername
        }
      } label: {
        Text("Create User")
      }
      .padding()
      
      switch validationMessage {
      case .firstMessage:
        Text("Enter an email and a password.")
          .foregroundColor(.teal)
      case .invalidPassword:
        Text("Password must contain 1 Uppercase, 1 Special character, and 2 numbers")
          .foregroundColor(.red)
      case .invalidUsername:
        Text("Must provide a valid email address")
          .foregroundColor(.red)
      case .validCredentials:
        Text("Account Created!")
          .font(.title2)
          .foregroundColor(.teal)
      }
    }
    .padding()
  }
  
  func checkCredentials() {
    validUsername = validEmail()
    validPassword = validate(password1: password1, password2: password2)
  }
  func validEmail() -> Bool {
    if username.contains("@") {
      return true
    } else {
      return false
    }
  }
  
  //currently only checking for one number
  func validate(password1: String, password2: String) -> Bool {
    let capitalLetterRegEx  = ".*[A-Z]+.*"
    let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
    guard texttest.evaluate(with: password1) else { return false }
    
    let numberRegEx  = ".*[0-9]+.*"
    let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
    guard texttest1.evaluate(with: password1) else { return false }
    
    let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
    let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
    guard texttest2.evaluate(with: password1) else { return false }
    
    guard password1.count >= 6 else { return false }
    return true
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
