//
//  CreateAccountPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct CreateAccountPage: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAppleLoading = false
    @State private var isGoogleLoading = false
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
                    .offset(x: 26, y: -240)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                Text("Let's get started")
                    .offset(x: 32, y: -226)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                    
                
                VStack(spacing: 20) {
                    Button(action: {
                        signInWithApple()
                    }) {
                        HStack {
                            if authViewModel.isLoading || isAppleLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 255/255, green: 248/255, blue: 228/255)))
                                    .scaleEffect(0.8)
                                Text("Signing up...")
                                    .padding(.leading, 8)
                            } else {
                                Image("apple")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Sign up with Apple")
                                    .padding(.leading, 8)
                            }
                        }
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                        .frame(width: 290, height: 40)
                        .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .cornerRadius(30)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                    }
                    .disabled(authViewModel.isLoading || isAppleLoading || isGoogleLoading)
                    
                    Button(action: {
                        signInWithGoogle()
                    }) {
                        HStack {
                            if authViewModel.isLoading || isGoogleLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 255/255, green: 248/255, blue: 228/255)))
                                    .scaleEffect(0.8)
                                Text("Signing up...")
                                    .padding(.leading, 8)
                            } else {
                                Image("google")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                Text("Sign up with Google")
                                    .padding(.leading, 8)
                            }
                        }
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                        .frame(width: 290, height: 40)
                        .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .cornerRadius(30)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                    }
                    .disabled(authViewModel.isLoading || isAppleLoading || isGoogleLoading)
                    
                    Text("Or")
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .bold()
                        .padding(.top, 5)
                    
                    NavigationLink(destination: CreateAccountEmail().environmentObject(authViewModel)) {
                        Text("I'll use email instead")
                            .bold()
                            .font(.system(size: 15))
                            .frame(width: 245, height: 32)
                            .background(Color.clear)
                            .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                    .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                            )
                    }
                }
                .offset(x: 33, y: -190)
                
                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .offset(y: -180)
                }
                
                // Add "Already have an account?" option
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.black.opacity(0.45))
                    
                    NavigationLink(destination: LoginPage().environmentObject(authViewModel)) {
                        Text("Login")
                            .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                            .bold()
                    }
                }
                .font(.system(size: 18))
                .offset(x: 50, y: -160)
            }
            .offset(x:22, y:40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 255/255, green: 248/255, blue: 228/255))
            .navigationBarHidden(true)
        }
    }
    
    private func signInWithGoogle() {
        print("🔍 Google Sign-In button tapped on CreateAccountPage")
        isGoogleLoading = true
        
        Task {
            do {
                print("🔍 Starting Google Sign-In...")
                let idToken = try await GoogleSignInManager.shared.signIn()
                print("🔍 Google Sign-In successful, got token: \(String(idToken.prefix(50)))...")
                print("🔍 Calling authViewModel.googleAuth...")
                await authViewModel.googleAuth(idToken: idToken)
                await MainActor.run {
                    isGoogleLoading = false
                }
            } catch {
                print("🔍 Google Sign-In failed: \(error)")
                await MainActor.run {
                    isGoogleLoading = false
                    authViewModel.errorMessage = "Google sign-in failed: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func signInWithApple() {
        print("🍎 Apple Sign-In button tapped on CreateAccountPage")
        isAppleLoading = true
        
        Task {
            do {
                print("🍎 Starting Apple Sign-In...")
                let result = try await AppleSignInManager.shared.signIn()
                print("🍎 Apple Sign-In successful, got result: \(result)")
                print("🍎 Calling authViewModel.appleAuth...")
                authViewModel.appleAuth(result: result)
                await MainActor.run {
                    isAppleLoading = false
                }
            } catch {
                print("🍎 Apple Sign-In failed: \(error)")
                await MainActor.run {
                    isAppleLoading = false
                    authViewModel.errorMessage = "Apple sign-in failed: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    CreateAccountPage()
        .environmentObject(AuthViewModel())
}
