//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct CreateAccountPage: View {
    
    @EnvironmentObject var appStateManager: AppStateManager
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading) {
                HStack{
                    
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .frame(width: 30, height: 23)
                        .offset(x:24, y:-250)
                    
                    Image("compass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 370, height: 370)
                        .rotationEffect(.degrees(-35))
                        .offset(x: 118, y: -180)
                }
                
                Text("Create Account")
                    .offset(x: 26, y: -270)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                Text("Let's get started")
                    .offset(x: 32, y: -256)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                
                
                VStack{
                    Button(action: {
                        print("Placeholder")
                    }) {
                        HStack{
                            Image("apple")
                                .resizable()
                                .frame(width:30, height:30)
                                .offset(x:-36)
                            Text("Sign up with Apple")
                                .offset(x:-16)
                        }
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                        .frame(width: 290, height: 40)
                        .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .cornerRadius(30)
                        .offset(x: 33, y: -230)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                    }
                    
                    Button(action: {
                        print("Placeholder")
                    }) {
                        HStack{
                            Image("google")
                                .resizable()
                                .frame(width:22, height:22)
                                .offset(x:-30)
                            Text("Sign up with Google")
                                .offset(x:-8)
                        }
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                        .frame(width: 290, height: 40)
                        .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .cornerRadius(30)
                        .offset(x: 33, y: -215)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                    }
                    
                    Text("Or")
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .bold()
                        .offset(x:35, y:-200)
                    
                    NavigationLink(destination: CreateAccountEmail().environmentObject(authViewModel).environmentObject(appStateManager)) {
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
                    .offset(x: 33, y: -190)
                }
                
                
            }
            .offset(x:22, y:40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 255/255, green: 248/255, blue: 228/255))
            
        }
    }
        
        
}

#Preview {
    CreateAccountPage()
}
