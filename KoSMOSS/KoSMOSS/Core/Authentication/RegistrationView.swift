//
//  RegistrationView.swift
//  KoSMOSS
//
//  Created by Vakhtang Saginadze on 03.11.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("firebaseLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 190, height: 210)
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeHolder: "name@example.com"
                )
                .autocapitalization(.none)
                
                InputView(text: $fullName,
                          title: "Full Name",
                          placeHolder: "name@example.com"
                )
                
                InputView(text: $password,
                          title: "Password",
                          placeHolder: "********",
                          isSecureField: true
                )
                .autocapitalization(.none)
                
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeHolder: "********",
                          isSecureField: true
                )
                .autocapitalization(.none)
                
                Button {
                    print("Sign user up...")
                } label: {
                    HStack {
                        Text("SIGN UP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(12)
                .padding(.top, 24)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Alread have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
