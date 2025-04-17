//
//  HomePage.swift
//  nomad-frontend
//

import SwiftUI

struct HomePage: View {
    // Dynamic variables
    @State private var username: String = "Anniee"
    @State private var cityName: String = "Houston"
    @State private var searchText: String = ""
    @State private var age: String = "40"
    
    let activity = ["musFineArts", "kemahBoard", "bayouBend"]
    let activityNames = ["Museum of Fine Arts", "Kemah Boardwalk", "Bayou Bend Gardens"]

    var activityText: String {
        if let ageInt = Int(age) {
            switch ageInt {
            case 13...19: return "Activities for your Teenage Years..."
            case 20...29: return "Activities for your Roaring 20's..."
            case 30...39: return "Activities for your Thriving 30's..."
            case 40...49: return "Activities for your Fabulous 40's..."
            case 50...59: return "Activities for your Golden 50's..."
            default: return "Activities for You..."
            }
        }
        return "Activities for You..."
    }
    
    var body: some View {
        VStack (spacing: 10) {
            VStack (spacing: 15) {
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
                
                // Logo and Username
                Image("nomadLogo")
                    .resizable()
                    .frame(width: 160, height: 45)
                
                Text("Hi, \(username)!")
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                    .offset(x: -115)
                
                // Current City Image
                ZStack(alignment: .top) {
                    Image("houstonbg")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 170)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("Welcome to")
                        .font(.system(size:20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: -100, y:20)
                    
                    Text(cityName) // Dynamic city name
                        .font(.system(size:50))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(y:60)
                }
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    TextField("Search an activity, nomad, etc.", text: $searchText)
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                }
                .padding(.horizontal)
                .frame(width: 250, height: 27)
                .background(Color(red: 227/255, green: 227/255, blue: 227/255))
                .cornerRadius(10)
            }
            
            // Activities Section
            ScrollView(.vertical, showsIndicators: false) {
                
                // Age-Based Activities
                VStack(alignment: .leading){
                    Text(activityText)
                        .font(.system(size:17))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(Array(zip(activity, activityNames)), id: \.0) { imageName, activityName in
                                VStack(alignment: .leading, spacing: 12) {
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 105)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                                    
                                    Text(activityName)
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .frame(width: 100, height: 50, alignment: .topLeading)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Trending Activities
                VStack(alignment: .leading){
                    Text("Trending near you. . .")
                        .font(.system(size:17))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(Array(zip(activity, activityNames)), id: \.0) { imageName, activityName in
                                VStack(alignment: .leading, spacing: 12) {
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 105)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                                    
                                    Text(activityName)
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .frame(width: 100, height: 50, alignment: .topLeading)
                                }
                            }
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
                Button(action: { print("Home tapped") }) {
                    Image("navhome")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                Button(action: { print("Feed tapped") }) {
                    Image("navfeed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                Button(action: { print("Log tapped") }) {
                    Image("navlog")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                Button(action: { print("Saved tapped") }) {
                    Image("navsaved")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                Spacer()
                Button(action: { print("Profile tapped") }) {
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
    HomePage()
}
