//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToCreateAccount = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                            .frame(width: 20, height: 16)
                    }
                    .padding(.leading, 30)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                
                Image("compass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370, height: 370)
                    .rotationEffect(.degrees(-35))
                    .offset(x: 175, y: -150)
                
                Text("Hi, there")
                    .offset(x: 41, y: -240)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                Text("Login to explore more")
                    .offset(x: 41, y: -226)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
               
                // Email field
                CustomTextField(
                    placeholder: "Email",
                    text: $email,
                    icon: "user",
                    isEmail: true
                )
                .frame(width: 330)
                .offset(x: 43, y: -208)
                
                // Password field
                CustomTextField(
                    placeholder: "Password",
                    text: $password,
                    icon: "lock",
                    isSecure: true
                )
                .frame(width: 330)
                .offset(x: 43, y: -180)
                
                HStack {
                    Text("Forgot?")
                        .offset(x: 325, y: -178)
                        .font(.system(size: 11))
                        .padding(.trailing, 10)
                        .bold()
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 5)
                }
                
                Button(action: {
                    authViewModel.login(email: email, password: password)
                }) {
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Login")
                            .bold()
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                    }
                }
                .frame(width: 310, height: 32)
                .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                .cornerRadius(30)
                .offset(x: 45, y: -160)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                .disabled(authViewModel.isLoading)
                
                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .offset(x: 45, y: -150)
                }
                
                Text("Or")
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                    .bold()
                    .offset(x:190, y:-140)
                
                HStack{
                    // Google Sign-In Button
                    Button(action: {
                        print("🔍 Google Sign-In button tapped")
                        Task {
                            do {
                                print("🔍 Starting Google Sign-In...")
                                let idToken = try await GoogleSignInManager.shared.signIn()
                                print("🔍 Google Sign-In successful, got token: \(String(idToken.prefix(50)))...")
                                print("🔍 Calling authViewModel.googleAuth...")
                                await authViewModel.googleAuth(idToken: idToken)
                            } catch {
                                print("🔍 Google Sign-In failed: \(error)")
                                authViewModel.errorMessage = "Google sign-in failed: \(error.localizedDescription)"
                            }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 4/255, green: 57/255, blue: 11/255))
                                .padding(-4)
                                .frame(width: 50, height: 50)
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .disabled(authViewModel.isLoading)
                    .offset(x:110, y:-130)
                    
                    // Apple Sign-In Button
                    Button(action: {
                        print("🍎 Apple Sign-In button tapped")
                        Task {
                            do {
                                print("🍎 Starting Apple Sign-In...")
                                let result = try await AppleSignInManager.shared.signIn()
                                print("🍎 Apple Sign-In successful, got result: \(result)")
                                print("🍎 Calling authViewModel.appleAuth...")
                                authViewModel.appleAuth(result: result)
                            } catch {
                                print("🍎 Apple Sign-In failed: \(error)")
                                authViewModel.errorMessage = "Apple sign-in failed: \(error.localizedDescription)"
                            }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 4/255, green: 57/255, blue: 11/255))
                                .padding(-4)
                                .frame(width: 50, height: 50)
                            Image("apple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                        }
                    }
                    .disabled(authViewModel.isLoading)
                    .offset(x:180, y:-130)
                }
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.45))
                    
                    NavigationLink(destination: CreateAccountPage().environmentObject(authViewModel)) {
                        Text("Sign up")
                            .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                            .bold()
                    }
                }
                .font(.system(size: 21))
                .offset(x: 50, y:-90)
            }
            .offset(y:40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 255/255, green: 248/255, blue: 228/255))
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginPage()
        .environmentObject(AuthViewModel())
}
