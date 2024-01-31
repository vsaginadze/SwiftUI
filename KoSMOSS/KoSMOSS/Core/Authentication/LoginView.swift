//
//  LoginView.swift
//  KoSMOSS
//
//  Created by Vakhtang Saginadze on 03.11.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("firebaseLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 190, height: 210)
                
                // form fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeHolder: "name@example.com"
                    )
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeHolder: "********",
                              isSecureField: true
                    )
                    .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                Button {
                    print("Log user in...")
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(12)
                .padding(.top, 24)
                
                Spacer()
                
                // sign up button
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
