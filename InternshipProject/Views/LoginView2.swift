//
//  LoginView2.swift
//  InternshipProject
//
//  Created by Christopher Koski on 10/5/22.
//

import SwiftUI

struct LoginView2: View {
  @StateObject var viewModel = LoginViewModel()
  
  
  
  @State private var alertMessage = ""
    var body: some View {
        VStack {
          Text("Welcome!")
            .font(.title)
            .fontWeight(.bold)
          VStack {
            TextField("Username", text: $viewModel.username)
              .padding(.leading)
              .padding(.top, 8)
            Divider()
            SecureField("Password", text: $viewModel.password1)
              .padding(.leading)
            Divider()
            SecureField("Retype Password", text: $viewModel.password2)
                .padding(.leading)
                .padding(.bottom, 8)
          }
          .background(.ultraThickMaterial, in: RoundedRectangle(
            cornerRadius: 16,
            style: .continuous))
          
          Button("Create User") {
            viewModel.checkCredentials()
            alertMessage = viewModel.getAlert()
          }
          .padding(8)
          .background(Color(.systemTeal))
          .foregroundColor(.white)
          .font(.title2)
          .fontWeight(.medium)
          .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
          
        }
        .padding()
        .alert(alertMessage, isPresented: $viewModel.showAlert) {
          Button("OK", role: .cancel) { }
        }
      }
    }

struct LoginView2_Previews: PreviewProvider {
    static var previews: some View {
      LoginView2(viewModel: LoginViewModel())
    }
}
