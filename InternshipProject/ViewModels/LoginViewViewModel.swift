//
//  LoginViewViewModel.swift
//  InternshipProject
//
//  Created by Christopher Koski on 10/5/22.
//

import Foundation

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

class LoginViewModel: ObservableObject {
  
  @Published var username: String = ""
  @Published var password1: String = ""
  @Published var password2: String = ""
  
  @Published var validationMessage: ValidationMessage = .firstMessage
  
  @Published var validUsername = false
  @Published var validPassword = false
  
  @Published var showAlert = false
  
  func checkCredentials() {
    validUsername = validEmail()
    validPassword = validate(password1: password1, password2: password2)
    
    if validUsername && validPassword {
      validationMessage = .validCredentials
    }
    
    if validationMessage != .validCredentials || validationMessage != .firstMessage {
      showAlert = true
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
  
  func getAlert() -> String {
    switch validationMessage {
    case .firstMessage:
      return ""
    case .mustHaveTwoNumbers:
      return "Password must have two numbers."
    case .mustHaveCapital:
      return "Password must have a capital letter."
    case .mustHaveSpecialCharacter:
      return "Password must have a special character."
    case .mustBe6Characters:
      return "Password must be at least 6 characters."
    case .invalidUsername:
      return "Username must be a valid email."
    case .passwordMismatch:
      return "Passwords must match."
    case .validCredentials:
      return "Account created!"
    }
  }
}
