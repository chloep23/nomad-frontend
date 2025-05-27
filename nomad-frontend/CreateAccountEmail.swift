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
                
                // Confirm Password field
                CustomTextField(
                    placeholder: "Confirm Password",
                    text: $confirmPassword,
                    icon: "lock",
                    isSecure: true
                )
                .frame(width: 330)
                .offset(x: 43, y: -152)
                
                // Password requirements - show when password field has text
                if !password.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Password must contain:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Image(systemName: password.count >= 8 ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(password.count >= 8 ? .green : .gray)
                                .font(.caption)
                            Text("At least 8 characters")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Image(systemName: containsUppercase(password) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(containsUppercase(password) ? .green : .gray)
                                .font(.caption)
                            Text("One uppercase letter")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Image(systemName: containsNumber(password) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(containsNumber(password) ? .green : .gray)
                                .font(.caption)
                            Text("One number")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .offset(x: 45, y: -140)
                }
                
                if let error = localError ?? authViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .offset(x: 45, y: !password.isEmpty ? -120 : -140)
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
                .background(canCreateAccount() ? Color(red: 4/255, green: 57/255, blue: 11/255) : Color.gray)
                .cornerRadius(30)
                .offset(x: 45, y: !password.isEmpty ? -100 : -120)
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
                .offset(x: 70, y: !password.isEmpty ? -80 : -100)
            }
            .offset(y:40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 255/255, green: 248/255, blue: 228/255))
            .navigationBarHidden(true)
        }
    }
    
    // Simple check for button state - doesn't trigger validation
    private func canCreateAccount() -> Bool {
        return !email.isEmpty && 
               !password.isEmpty && 
               !confirmPassword.isEmpty &&
               password.count >= 8
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8 && 
               containsUppercase(password) && 
               containsNumber(password)
    }
    
    private func containsUppercase(_ string: String) -> Bool {
        return string.range(of: "[A-Z]", options: .regularExpression) != nil
    }
    
    private func containsNumber(_ string: String) -> Bool {
        return string.range(of: "[0-9]", options: .regularExpression) != nil
    }
    
    private func createAccount() {
        // Clear any previous error
        localError = nil
        
        // Validate all fields when user attempts to create account
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            localError = "All fields are required"
            return
        }
        
        guard isValidEmail(email) else {
            localError = "Please enter a valid email address"
            return
        }
        
        guard password == confirmPassword else {
            localError = "Passwords do not match"
            return
        }
        
        guard isValidPassword(password) else {
            localError = "Password does not meet requirements"
            return
        }
        
        // All validation passed, proceed with account creation
        authViewModel.register(email: email, password: password)
    }
}

#Preview {
    CreateAccountEmail()
        .environmentObject(AuthViewModel())
}
