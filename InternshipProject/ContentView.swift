//
//  ContentView.swift
//  InternshipProject
//
//  Created by Christopher Koski on 10/5/22.
//

import SwiftUI

enum ValidationMessage {
  case firstMessage
  case mustHaveTwoNumbers
  case mustHaveCapital
  case mustHaveSpecialCharacter
  case mustBe6Characters
  case invalidUsername
  case passwordMismatch
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
        
        SecureField("Retype Password", text: $password2)
      }
      
      Button {
        checkCredentials()
      } label: {
        Text("Create User")
      }
      .padding()
      
      switch validationMessage {
      case .firstMessage:
        Text("Enter an email and a password.")
          .foregroundColor(.teal)
      case .mustHaveTwoNumbers:
        Text("Password must contain 2 numbers.")
          .foregroundColor(.red)
      case .mustHaveCapital:
        Text("Passsord must contain a capital letter.")
          .foregroundColor(.red)
      case .mustHaveSpecialCharacter:
        Text("Password must contain a special character.")
          .foregroundColor(.red)
      case .mustBe6Characters:
        Text("Password must be at least 6 characters.")
          .foregroundColor(.red)
      case .invalidUsername:
        Text("Must provide a valid email address")
          .foregroundColor(.red)
      case .passwordMismatch:
        Text("Passwords must match.")
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
    
    if validUsername && validPassword {
      validationMessage = .validCredentials
    }
  }
  func validEmail() -> Bool {
    if username.contains("@") {
      return true
    } else {
      validationMessage = .invalidUsername
      return false
    }
  }
  
  func validate(password1: String, password2: String) -> Bool {
    
    guard password1 == password2 else {
      validationMessage = .passwordMismatch
      return false
    }
    
    let amountOfNumbers = password1.filter {"0"..."9" ~= $0 }.count
    print(amountOfNumbers)
    guard amountOfNumbers >= 2 else {
      validationMessage = .mustHaveTwoNumbers
      return false
    }
    
    let capitalLetterRegEx  = ".*[A-Z]+.*"
    let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
    guard texttest.evaluate(with: password1) else {
      validationMessage = .mustHaveCapital
      return false
    }
    
    let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
    let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
    guard texttest2.evaluate(with: password1) else {
      validationMessage = .mustHaveSpecialCharacter
      return false
      
    }
    
    guard password1.count >= 6 else {
      validationMessage = .mustBe6Characters
      return false
    }
    
    return true
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
