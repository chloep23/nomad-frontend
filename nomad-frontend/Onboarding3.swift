//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct Onboarding3: View {
    
    @State private var birthday: String = ""
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading) {
                
                Image("traveling")
                    .resizable()
                    .frame(width: 55, height:55)
                    .offset(x: 95, y:-110)
                Text("Step 3")
                    .offset(x: 90, y: -100)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                
                Text("How old are you?")
                    .offset(x: -20, y: -85)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                
                
                VStack {
                    ZStack(alignment: .leading) {
                        // Placeholder Text
                        if birthday.isEmpty {
                            Text("mm/dd/yyyy")
                                .font(.system(size: 15))
                                .foregroundColor(.black.opacity(0.45))
                                .offset(x: 18)
                        }
                        
                        // Editable TextField
                        TextField("", text: $birthday)
                            .padding(.horizontal, 15)
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .frame(width: 300, height: 37)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.black.opacity(0.45))
                                    .shadow(color: .black.opacity(0.8), radius: 2, x: -2, y: 4)
                            )
                    }
                    .offset(x: -20, y: -65)
                }
                
                NavigationLink(destination: Onboarding4()) {
                    HStack{
                        Text("Next")
                            .offset(x:-9)
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 17, height:13)
                            .offset(x:3)
                    }
                    .bold()
                    .font(.system(size: 17))
                    .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                    .frame(width: 108, height: 32)
                    .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                }
                .offset(x: 180, y: -20)
                
                Image("5dots3")
                    .resizable()
                    .frame(width:120, height:12)
                    .offset(x:65, y:190)
                
                
            }
            .offset(x:22, y:40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 255/255, green: 248/255, blue: 228/255))
            
        }
    }
        
        
}

#Preview {
    Onboarding3()
}
