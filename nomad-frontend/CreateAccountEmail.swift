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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
                Button(action: {
                        dismiss()  // This makes it behave like a back button
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                            .frame(width: 30, height: 23)
                            .offset(x: 24, y: -290)
                    }
                    
                Image("compass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370, height: 370)
                    .rotationEffect(.degrees(-35))
                    .offset(x: 120, y: -200)
            }
            
            Text("Create Account")
                .offset(x: 26, y: -290)
                .font(.system(size: 40))
                .bold()
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
            Text("Let's get started")
                .offset(x: 32, y: -276)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
           
            // Email TextField with Underline and Shadow
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image("email")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 22, height: 17)

                    ZStack(alignment: .leading) {
                        if email.isEmpty {
                            Text("Email")
                                .foregroundColor(.black.opacity(0.45))
                        }

                        TextField("", text: $email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                    }
                }
                .padding(.bottom, 5)
                .offset(x:5)
                .overlay(
                    Rectangle()
                        .frame(width: 300, height: 1)
                        .offset(x:-55)
                        .foregroundColor(.gray.opacity(0.5))
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 4),
                    alignment: .bottom
                )
                .offset(x: 31, y: -256)
            }

            // Password SecureField with Underline and Shadow
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image("lock")
                        .foregroundColor(.gray)

                    ZStack(alignment: .leading) {
                        if password.isEmpty {
                            Text("Password")
                                .foregroundColor(.black.opacity(0.45))
                        }

                        SecureField("", text: $password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                    }
                }
                .padding(.bottom, 5)
                .offset(x:5)
                .overlay(
                    Rectangle()
                        .frame(width: 300, height: 1)
                        .offset(x:-55)
                        .foregroundColor(.gray.opacity(0.5))
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 4),
                    alignment: .bottom
                )
                .offset(x: 31, y: -230)
            }

            // Confirm Password SecureField with Underline and Shadow
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image("lock")
                        .foregroundColor(.gray)

                    ZStack(alignment: .leading) {
                        if cpassword.isEmpty {
                            Text("Confirm Password")
                                .foregroundColor(.black.opacity(0.45))
                        }

                        SecureField("", text: $cpassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                    }
                }
                .padding(.bottom, 5)
                .offset(x:5)
                .overlay(
                    Rectangle()
                        .frame(width: 300, height: 1)
                        .offset(x:-55)
                        .foregroundColor(.gray.opacity(0.5))
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 4),
                    alignment: .bottom
                )
                .offset(x: 31, y: -204)
            }
            
            // Add validation and error display
            if let error = localError ?? authViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .offset(x: 31, y: -220)
            }
            
            // Update the Ready button
            Button(action: {
                if password != confirmPassword {
                    localError = "Passwords do not match"
                    return
                }
                localError = nil
                authViewModel.register(email: email, password: password)
            }) {
                if authViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    HStack{
                        Text("Ready")
                            .offset(x:-7)
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 17, height:13)
                    }
                    .bold()
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                }
            }
            .frame(width: 115, height: 32)
            .background(Color(red: 4/255, green: 57/255, blue: 11/255))
            .cornerRadius(30)
            .offset(x: 215, y: -180)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
            .disabled(authViewModel.isLoading)
        }
        .offset(x:20, y:40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
    }

    func registerUser(email: String, password: String) {
        
        guard let url = URL(string: "https://zj38dblmvj.execute-api.us-east-1.amazonaws.com/prod/register")
        
        else {
            self.message = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": email, "password": password]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            self.message = "Failed to encode request"
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.message = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.message = "No response data"
                    return
                }

                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                    self.message = "Response: \(jsonResponse)"
                } else {
                    self.message = "Invalid response format"
                }
            }
        }

        task.resume()
    }
}

        
#Preview {
    CreateAccountEmail()
}
