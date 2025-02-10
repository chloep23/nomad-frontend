//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct Onboarding5: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Image("traveling")
                .resizable()
                .frame(width: 55, height:55)
                .offset(x: 240, y:-110)
            Text("Final Step")
                .offset(x: 90, y: -100)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
            
            Text("What do you like?")
                .offset(x: -20, y: -85)
                .font(.system(size: 40))
                .bold()
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
            
            
            HStack{
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Landmarks")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 112, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: -20, y: -70)
                }
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Shopping")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 110, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: -10, y: -70)
                }
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Nature")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 80, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: 0, y: -70)
                }
            }
            .offset(x:-10)
            
            HStack{
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Museum")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 90, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: -20, y: -70)
                }
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Nightlife")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 95, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: -10, y: -70)
                }
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Art")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 50, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: 0, y: -70)
                }
            }
            .offset(x:20, y:9)
            
            HStack{
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Entertainment")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 142, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: -20, y: -70)
                }
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Sports")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 80, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: -10, y: -70)
                }
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Other")
                        .bold()
                        .font(.system(size: 15))
                        .frame(width: 80, height: 30)
                        .background(Color.clear)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                        )
                        .offset(x: 0, y: -70)
                }
            }
            .offset(x:-10, y:20)
            
            
            Button(action: {
                print("Placeholder")
            }) {
                HStack{
                    Text("Begin")
                        .offset(x:-9)
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 17, height:13)
                        .offset(x:3)
                }
                .bold()
                .font(.system(size: 17))
                .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                .frame(width: 118, height: 30)
                .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                .cornerRadius(30)
                .offset(x: 180, y: -20)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
            }
            
            Image("5dots5")
                .resizable()
                .frame(width:120, height:12)
                .offset(x:65, y:130)
            
        }
        .offset(x:22, y:70)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
        

    }
        
        
}

#Preview {
    Onboarding5()
}
