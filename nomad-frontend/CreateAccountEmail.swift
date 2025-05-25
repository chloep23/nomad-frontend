//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI
import Foundation

struct CreateAccountEmail: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var localError: String?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Image("compass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370, height: 370)
                    .rotationEffect(.degrees(-35))
                    .offset(x: 175, y: -150)
                
                Text("Create Account")
                    .offset(x: 41, y: -240)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                Text("Let's get started")
                    .offset(x: 41, y: -226)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
               
                
                VStack(alignment: .leading, spacing: 0){
                    HStack {
                        Image("user")
                            .foregroundColor(.gray)
                        if email.isEmpty {
                                Text("Email")
                                    .foregroundColor(.black.opacity(0.45))
                            }

                            TextField("", text: $email)
                                .foregroundColor(.gray.opacity(1))
                                .font(.system(size: 18))
                    }
                    .padding(.bottom, 4)
                    .offset(x:2)
                    .overlay(
                        Rectangle()
                            .frame(width: 330, height: 1)
                            .foregroundColor(.gray.opacity(5))
                            .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 5)
                            .offset(x: -40),
                        alignment: .bottom
                    )
                    .offset(x: 41, y: -208)
                }
                
                
                VStack(alignment: .leading, spacing: 0){
                    HStack {
                        Image("lock")
                            .foregroundColor(.gray)
                        if password.isEmpty {
                            Text("Password")
                                .foregroundColor(.black.opacity(0.45))
                                .offset(x:3)
                            }

                            SecureField("", text: $password)
                            .foregroundColor(.black.opacity(0.45))
                                .font(.system(size: 18))
                    }
                    .padding(.bottom, 4)
                    .offset(x:2)
                    .overlay(
                        Rectangle()
                            .frame(width: 330, height: 1)
                            .foregroundColor(.gray.opacity(5))
                            .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 5)
                            .offset(x: -40),
                        alignment: .bottom)
                    .offset(x: 41, y: -180)
                }
                
                VStack(alignment: .leading, spacing: 0){
                    HStack {
                        Image("lock")
                            .foregroundColor(.gray)
                        if confirmPassword.isEmpty {
                            Text("Confirm Password")
                                .foregroundColor(.black.opacity(0.45))
                                .offset(x:3)
                            }

                            SecureField("", text: $confirmPassword)
                            .foregroundColor(.black.opacity(0.45))
                                .font(.system(size: 18))
                    }
                    .padding(.bottom, 4)
                    .offset(x:2)
                    .overlay(
                        Rectangle()
                            .frame(width: 330, height: 1)
                            .foregroundColor(.gray.opacity(5))
                            .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 5)
                            .offset(x: -40),
                        alignment: .bottom)
                    .offset(x: 41, y: -152)
                }
                
                if let error = localError ?? authViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .offset(x: 45, y: -140)
                }
                
                Button(action: {
                    createAccount()
                }) {
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Create Account")
                            .bold()
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                    }
                }
                .frame(width: 310, height: 32)
                .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                .cornerRadius(30)
                .offset(x: 45, y: -120)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                .disabled(authViewModel.isLoading)
                
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.black.opacity(0.45))
                    
                    NavigationLink(destination: LoginPage().environmentObject(authViewModel)) {
                        Text("Login")
                            .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                            .bold()
                    }
                }
                .font(.system(size: 21))
                .offset(x: 70, y: -100)
            }
            .offset(y:40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 255/255, green: 248/255, blue: 228/255))
            .navigationBarHidden(true)
        }
    }
    
    private func createAccount() {
        localError = nil
        
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            localError = "All fields are required"
            return
        }
        
        guard password == confirmPassword else {
            localError = "Passwords do not match"
            return
        }
        
        guard password.count >= 6 else {
            localError = "Password must be at least 6 characters"
            return
        }
        
        authViewModel.register(email: email, password: password)
    }
}

#Preview {
    CreateAccountEmail()
        .environmentObject(AuthViewModel())
}
