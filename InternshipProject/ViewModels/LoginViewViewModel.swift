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
}
