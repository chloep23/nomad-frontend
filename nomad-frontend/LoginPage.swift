//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct LoginPage: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
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
           
            
            // Username TextField
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image("user")
                        .foregroundColor(.gray)

                    ZStack(alignment: .leading) {
                        if username.isEmpty {
                            Text("Username")
                                .foregroundColor(.black.opacity(0.45))
                        }

                        TextField("", text: $username)
                            .foregroundColor(.gray.opacity(1))
                            .font(.system(size: 18))
                    }
                }
                .padding(.bottom, 4)
                .overlay(
                    Rectangle()
                        .frame(width: 330, height: 1)
                        .foregroundColor(.gray.opacity(0.5))
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 4)
                        .offset(x: -40),
                    alignment: .bottom
                )
                .offset(x: 41, y: -208)
            }

            // Password SecureField
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
                            .foregroundColor(.black.opacity(1))
                            .font(.system(size: 18))
                    }
                }
                .padding(.bottom, 4)
                .overlay(
                    Rectangle()
                        .frame(width: 330, height: 1)
                        .foregroundColor(.gray.opacity(0.5))
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 4)
                        .offset(x: -40),
                    alignment: .bottom
                )
                .offset(x: 41, y: -180)
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
                    Text("Login")
                }
                .bold()
                .font(.system(size: 18))
                .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                .frame(width: 310, height: 32)
                .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                .cornerRadius(30)
                .offset(x: 45, y: -160)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 3, y: 5)
            }
            
           
            Text("Or")
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                .bold()
                .offset(x:190, y:-140)
            
            HStack{
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
                .offset(x:140, y:-130)
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
                .offset(x:155, y:-130)
            }
            
            
            
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(.black.opacity(0.45))
                Text("Sign up")
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                    .bold()
            }
            .font(.system(size: 21))
            .offset(x: 50, y:-10)
            
        }
        .offset(y:40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
        

    }
        
        
}

#Preview {
    LoginPage()
}
