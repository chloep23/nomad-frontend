//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct LoginPage: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Image("compass")
                .resizable()
                .scaledToFit()
                .frame(width: 370, height: 370)
                .rotationEffect(.degrees(-35))
                .offset(x: 175, y: -150)
            Text("Login")
                .offset(x: 38, y: -240)
                .font(.system(size: 40))
                .bold()
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
            Text("Please sign in to continue")
                .offset(x: 38, y: -226)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
           
            
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Image("user")
                        .foregroundColor(.gray)
                    if email.isEmpty { //when user hasn't typed anything
                            Text("Username")
                                .foregroundColor(.black.opacity(0.45))
                        }

                        TextField("", text: $email)
                            .foregroundColor(.gray.opacity(1))
                            .font(.system(size: 18))
                }
                .padding(.bottom, 4)
                .overlay(
                    Rectangle()
                        .frame(width: 330, height: 1)
                        .foregroundColor(.gray.opacity(5))
                        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 5)
                        .offset(x: -36),
                    alignment: .bottom
                )
                .offset(x: 38, y: -208)
            }
            
            
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Image("lock")
                        .foregroundColor(.gray)
                    if password.isEmpty { //when user hasn't typed anything
                            Text("Password")
                            .foregroundColor(.black.opacity(0.45))                          }

                        TextField("", text: $password)
                        .foregroundColor(.black.opacity(0.45))
                            .font(.system(size: 18))
                }
                .padding(.bottom, 5)
                .overlay(
                    Rectangle()
                        .frame(width: 330, height: 1)
                        .foregroundColor(.gray.opacity(5))
                        .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 5)
                        .offset(x: -36),
                    alignment: .bottom)
                .offset(x: 38, y: -180)
            }
            
        
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
                print("Placeholder")
            }) {
                HStack{
                    Text("Ready")
                        .offset(x: -5)
                    Image(systemName: "arrow.right")
                }
                .bold()
                .font(.system(size: 18))
                .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                .frame(width: 118, height: 32)
                .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                .cornerRadius(30)
                .offset(x: 248, y: -160)
            }
            
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(.black.opacity(0.45))
                Text("Sign up")
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                    .bold()
            }
            .font(.system(size: 21))
            .offset(x: 50, y: 60)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))

    }
        
}

#Preview {
    LoginPage()
}
