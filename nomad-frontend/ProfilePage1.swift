//
//  ProfilePage1.swift
//  nomad-frontend
//

import SwiftUI

struct ProfilePage1: View {
    let experiences: [Experience] = [
        Experience(number: 1, name: "Seoul", category: "South Korea } 7035 mi", rating: 10),
        Experience(number: 2, name: "San Diego", category: "California | 1460 mi", rating: 9.9),
        Experience(number: 3, name: "Sydney", category: "Australia | 8581 mi", rating:9.3),
    ]
    
    let gridImages = ["londonbg", "praguebg", "seoulbg"]
    let gridCities = ["London", "Prague", "Seoul"]
    let gridActs = ["9 activities", "10 activities", "4 activities"]
    let columns = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]
    var body: some View {
        VStack (spacing: 10){
            VStack (spacing:5){
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding()
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 17, height: 17)
                        .padding(.top, 3)
                }
                .offset(x: 130, y: 0)
                Text("Anniee Fang")
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(.black)
                Text("@ahf1216")
                    .font(.system(size:17))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Image("profilepic")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 130, height: 160)
                Text("Houston, TX")
                    .font(.system(size:17))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Edit profile")
                        .font(.system(size: 15))
                        .frame(width: 120, height: 27)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.gray)
                        )
                }
            }
            HStack{
                VStack{
                    HStack{
                        Image("grid")
                            .padding(.leading, 70)
                        Text("Journal")
                            .foregroundColor(.black)
                    }
                    .padding(.top, 15)
                    Rectangle()
                        .frame(height: 2)
                        .frame(maxWidth: 130)
                        .foregroundColor(.black)
                        .offset(x: 40)
                }
                Spacer()
                Image("rank")
                Text("Ranking")
                    .padding(.trailing, 70)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(gridImages, id: \.self) { imageName in
                    ZStack(alignment: .bottom){
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 105)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("London")
                            .font(.system(size:17))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(x: -14, y:-75)
                        Text("9 activities")
                            .font(.system(size:10))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(x: 14, y:-8)
                    }
                    
                }
            }
            .padding(.horizontal)
            .frame(maxHeight: 320, alignment: .top)
        }
        
        // Bottom Navigation Bar
        VStack {
            Divider()
            HStack {
                Spacer()
                VStack {
                    Image("navhome")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                VStack {
                    Image("navfeed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                VStack {
                    Image("navlog")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                VStack {
                    Image("navsaved")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                VStack {
                    Image("navprofile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
            }
            .padding(.vertical, 2)
            .offset(y:6)
        }
    }
}

#Preview {
    ProfilePage1()
}
