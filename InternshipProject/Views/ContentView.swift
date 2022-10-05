//
//  ContentView.swift
//  InternshipProject
//
//  Created by Christopher Koski on 10/5/22.
//

import SwiftUI



struct LoginView: View {
  
  @StateObject var viewModel = LoginViewModel()
  
  @State private var validUsername = false
  @State private var validPassword = false
  
  var body: some View {
    VStack {
      Text("Welcome!")
        .font(.title)
        .fontWeight(.bold)
      VStack {
        TextField("Username", text: $viewModel.username)
        SecureField("Password", text: $viewModel.password1)
        
        SecureField("Retype Password", text: $viewModel.password2)
      }
      
      Button {
        checkCredentials()
      } label: {
        Text("Create User")
      }
      .padding()
      
      switch viewModel.validationMessage {
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
    validPassword = validate(password1: viewModel.password1, password2: viewModel.password2)
    
    if validUsername && validPassword {
      viewModel.validationMessage = .validCredentials
    }
  }
  func validEmail() -> Bool {
    if viewModel.username.contains("@") {
      return true
    } else {
      viewModel.validationMessage = .invalidUsername
      return false
    }
  }
  
  func validate(password1: String, password2: String) -> Bool {
    
    guard password1 == password2 else {
      viewModel.validationMessage = .passwordMismatch
      return false
    }
    
    let amountOfNumbers = password1.filter {"0"..."9" ~= $0 }.count
    print(amountOfNumbers)
    guard amountOfNumbers >= 2 else {
      viewModel.validationMessage = .mustHaveTwoNumbers
      return false
    }
    
    let capitalLetterRegEx  = ".*[A-Z]+.*"
    let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
    guard texttest.evaluate(with: password1) else {
      viewModel.validationMessage = .mustHaveCapital
      return false
    }
    
    let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
    let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
    guard texttest2.evaluate(with: password1) else {
      viewModel.validationMessage = .mustHaveSpecialCharacter
      return false
      
    }
    
    guard password1.count >= 6 else {
      viewModel.validationMessage = .mustBe6Characters
      return false
    }
    
    return true
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
