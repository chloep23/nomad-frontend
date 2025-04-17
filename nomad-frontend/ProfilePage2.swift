//
//  ProfilePage2.swift
//  nomad-frontend
//

import SwiftUI

struct ProfilePage2: View {
    let experiences: [Experience] = [
        Experience(number: 1, name: "Seoul", category: "South Korea } 7035 mi", rating: 10),
        Experience(number: 2, name: "San Diego", category: "California | 1460 mi", rating: 9.9),
        Experience(number: 3, name: "Sydney", category: "Australia | 8581 mi", rating:9.3),
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
                Image("grid")
                    .padding(.leading, 70)
                Text("Journal")
                    .foregroundColor(.gray)
                Spacer()
                VStack{
                    HStack{
                        Image("rank")
                        Text("Ranking")
                            .padding(.trailing, 70)
                    }
                    .padding(.top, 15)
                    Rectangle()
                            .frame(height: 2)
                            .frame(maxWidth: 130)
                            .foregroundColor(.black)
                            .offset(x: -30)
                }
            }
            .padding(.bottom, 10)
            HStack{
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("City")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.gray)
                                .frame(width: 55, height: 27)
                        )
                }
                .padding(.horizontal, 15)
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Activity")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.gray)
                                .frame(width: 75, height: 27)
                        )
                }
                .padding(.horizontal, 15)
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Shopping")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.gray)
                                .frame(width: 95, height: 27)
                        )
                }
                .padding(.horizontal, 15)
                Button(action: {
                    print("Placeholder")
                }) {
                    Text("Landmark")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.gray)
                                .frame(width: 100, height: 27)
                        )
                }
                .padding(.horizontal, 20)
            }
            List(experiences) { experience in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(experience.number). \(experience.name)")
                            .offset(y:-5)
                            .font(.system(size: 16))
                            .bold()
                        Text(experience.category)
                            .offset(y: 3)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(
                        experience.rating == 10.0
                            ? "10"
                            : String(format: "%.1f", experience.rating)
                    )
                    .font(.system(size:17))
                    .bold()
                        .padding(7)
                        .background(
                                experience.rating >= 9.0
                                ? Color(red: 4/255, green: 57/255, blue: 11/255)
                                : Color(red: 255/255, green: 248/255, blue: 228/255)
                            )
                        .clipShape(Circle())
                        .frame(width: 50, height: 44)
                        .foregroundColor(experience.rating >= 9.0
                                         ? Color(red: 255/255, green: 248/255, blue: 228/255)
                                         : Color(red: 4/255, green: 57/255, blue: 11/255))
                }
                .padding(.vertical, 17)
            }
            .listStyle(PlainListStyle())

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
    ProfilePage2()
}
