//
//  ContentView.swift
//  InternshipProject
//
//  Created by Christopher Koski on 10/5/22.
//

import SwiftUI



struct LoginView: View {
  
  @StateObject var viewModel = LoginViewModel()
  
  
  
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
        viewModel.checkCredentials()
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

}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
