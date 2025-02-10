//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct CreateAccountEmail: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "arrow.left")
                    .resizable()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                    .frame(width: 30, height: 23)
                    .offset(x:24, y:-290)
                    
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
           
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Image("email")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 22, height:17)
                        .offset(x:-2)
                    if email.isEmpty { //when user hasn't typed anything
                            Text("Email")
                                .foregroundColor(.black.opacity(0.45))
                        }

                        TextField("", text: $email)
                            .foregroundColor(.gray.opacity(1))
                            .font(.system(size: 18))
                }
                .padding(.bottom, 5)
                .offset(x:5)
                .overlay(
                    Rectangle()
                        .frame(width: 300, height: 1)
                        .foregroundColor(.gray.opacity(5))
                        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 5)
                        .offset(x: -55),
                    alignment: .bottom
                )
                .offset(x: 31, y: -256)
            }
            
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Image("lock")
                        .foregroundColor(.gray)
                    if email.isEmpty { //when user hasn't typed anything
                            Text("Password")
                                .foregroundColor(.black.opacity(0.45))
                        }

                        TextField("", text: $email)
                            .foregroundColor(.gray.opacity(1))
                            .font(.system(size: 18))
                }
                .padding(.bottom, 5)
                .offset(x:5)
                .overlay(
                    Rectangle()
                        .frame(width: 300, height: 1)
                        .foregroundColor(.gray.opacity(5))
                        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 5)
                        .offset(x: -55),
                    alignment: .bottom
                )
                .offset(x: 31, y: -230)
            }
            
            
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Image("lock")
                        .foregroundColor(.gray)
                    if password.isEmpty { //when user hasn't typed anything
                        Text("Confirm Password")
                            .foregroundColor(.black.opacity(0.45))
                            .offset(x:3)
                        }

                        TextField("", text: $password)
                        .foregroundColor(.black.opacity(0.45))
                            .font(.system(size: 18))
                }
                .padding(.bottom, 5)
                .offset(x:5)
                .overlay(
                    Rectangle()
                        .frame(width: 300, height: 1)
                        .foregroundColor(.gray.opacity(5))
                        .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 5)
                        .offset(x: -55),
                    alignment: .bottom)
                .offset(x: 31, y: -204)
            }
            
            Button(action: {
                print("Placeholder")
            }) {
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
                .frame(width: 115, height: 32)
                .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                .cornerRadius(30)
                .offset(x: 215, y: -180)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
            }
            
        }
        .offset(x:20, y:40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
        

    }
        
        
}

#Preview {
    CreateAccountEmail()
}
