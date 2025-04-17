//
//  ProfilePage1.swift
//  nomad-frontend
//

import SwiftUI

struct ProfilePage1: View {
    // Dynamic variables
    @State private var name: String = "Anniee Fang"
    @State private var username: String = "@ahf1216"
    @State private var searchText: String = ""
    @State private var location: String = "Houston, TX"
    
    let experiences: [Experience] = [
        Experience(number: 1, name: "Seoul", category: "South Korea } 7035 mi", rating: 10),
        Experience(number: 2, name: "San Diego", category: "California | 1460 mi", rating: 9.9),
        Experience(number: 3, name: "Sydney", category: "Australia | 8581 mi", rating:9.3),
    ]
    
    let gridImages = ["londonbg", "praguebg", "seoulbg", "londonbg", "praguebg", "seoulbg", "londonbg", "praguebg", "seoulbg"]
    let gridCities = ["London", "Prague", "Seoul", "London", "Prague", "Seoul", "London", "Prague", "Seoul"]
    let gridActs = ["9 activities", "10 activities", "4 activities", "9 activities", "10 activities", "4 activities", "9 activities", "10 activities", "4 activities"]
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
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 17, height: 17)
                        .padding(.top, 3)
                        .offset(x:10)
                }
                .offset(x: 130, y: 0)
                Text(name)
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(.black)
                Text(username)
                    .font(.system(size:17))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Image("profilepic")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 130, height: 160)
                Text(location)
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
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(gridImages.indices, id: \.self) { index in
                        ZStack(alignment: .bottom) {
                            Image(gridImages[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 105)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(gridCities[index]) // Dynamic city name
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(x: -14, y: -75)
                            
                            Text(gridActs[index]) // Dynamic activity text
                                .font(.system(size: 10))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(x: 14, y: -8)
                        }
                    }
                }
                .padding(.horizontal)
            }
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
