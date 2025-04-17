//
//  FeedPage.swift
//  nomad-frontend
//

import SwiftUI

struct Username: Identifiable {
    let id = UUID()
    let pic: String
    let name: String
    let activity: String
    let location: String
    let rating: Double
    let time: String
}

struct FeedPage: View {
    let users: [Username] = [
        Username(pic: "fiona", name: "Fiona Guo", activity: "The Opera House Tour", location: "Sydney, Australia", rating: 10, time: "5 min ago"),
        Username(pic: "carden", name: "Carden Royster", activity: "Lovers Beach", location: "Cabo, Mexico", rating: 9.8, time: "17 min ago"),
        Username(pic: "jeffrey", name: "Jeffrey Su", activity: "Disney World", location: "Orlando, Florida", rating: 8.6, time: "1 day ago"),
        Username(pic: "soohyun", name: "Soohyun Cho", activity: "The Navy Pier", location: "Chicago, Illinois", rating: 8.6, time: "1 day ago"),
    ]

    var body: some View {
        VStack (spacing: 10){
            VStack (spacing:15){
                HStack {
                    Button(action: {
                        print("Notification button tapped")
                    }) {
                        Image(systemName: "bell.badge")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        print("Menu button tapped")
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 17, height: 17)
                            .padding(.top, 3)
                            .offset(x:10)
                    }
                }
                .offset(x: 130, y: 0)
                
                HStack(){
                    Image("nomadLogo")
                        .resizable()
                        .frame(width: 160, height: 45)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            
                HStack() {
                    Image("feet")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("You've got 27 potential nomads")
                        .font(.system(size: 17))
                        .bold()
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .padding(.vertical, 5)
                    Image(systemName: "chevron.right")
                        .font(.body)
                        .bold()
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .offset(x:10)
                }
                .offset(x:-3)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 227/255, green: 227/255, blue: 227/255))
                        .frame(width: 340, height: 70)
                )
                .padding(.horizontal)
            }
            .padding(.bottom, 30)
           
            VStack(){
                Text("Recents")
                    .font(.system(size: 17))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                Rectangle()
                    .frame(height: 2)
                    .frame(maxWidth: 100)
                    .foregroundColor(.black)
            }
            .offset(x:-130)
            
            
            List(users) { user in
                HStack (spacing: 20){
                    Image(user.pic)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)

                    VStack(alignment: .leading) {
                        Text("\(user.name) ")
                            .font(.system(size: 16))
                            .bold() // Bold only the name

                        + Text("ranked ")
                            .font(.system(size: 16)) // Regular text

                        + Text("\(user.activity)")
                            .font(.system(size: 16))
                            .bold() // Bold only the activity

                        HStack(){
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.gray)
                                .font(.callout)
                            Text(user.location)
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        .offset(y: 8)
                    }
                    
                    Spacer()
                    Text("\(user.rating, specifier: "%.1f")")
                        .font(.system(size: 17))
                        .bold()
                        .padding(7)
                        .frame(width: 50, height: 44)
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255)) // Green text
                        .overlay(
                            Circle().stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 2)
                        )
                        .clipShape(Circle())
                }
                Text(user.time)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                .padding(.vertical, 17)
                .listRowSeparator(.hidden)
                Divider()
                    .background(Color.gray.opacity(0.5))
                    .listRowSeparator(.hidden)
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
    FeedPage()
}
