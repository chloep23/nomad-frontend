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
    
    // Use AuthViewModel for logout functionality
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // Navigation state variables
    @State private var showLondonPage = false
    @State private var showPraguePage = false
    @State private var slideDirection: SlideDirection = .rightToLeft
    
    enum SlideDirection {
        case leftToRight
        case rightToLeft
    }
    
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
    
    // Function to handle navigation with custom animation
    func navigateToCity(_ cityName: String, at index: Int) {
        // Always slide from left for all locations
        slideDirection = .leftToRight
        
        // Navigate to appropriate page
        switch cityName {
        case "London":
            showLondonPage = true
        case "Prague":
            showPraguePage = true
        default:
            break
        }
    }
    
    var body: some View {
        ZStack {
            // Main content
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
                    
                    // Logout button using AuthViewModel
                    Button(action: {
                        authViewModel.logout()
                    }) {
                        Text("Logout")
                            .font(.system(size: 15))
                            .frame(width: 120, height: 27)
                            .foregroundColor(.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.red)
                            )
                    }
                    .padding(.top, 8)
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
                            let cityName = gridCities[index]
                            
                            // Check if city has a dedicated page
                            if cityName == "London" || cityName == "Prague" {
                                Button(action: {
                                    navigateToCity(cityName, at: index)
                                }) {
                                    CityGridItem(
                                        imageName: gridImages[index],
                                        cityName: cityName,
                                        activityText: gridActs[index]
                                    )
                                }
                            } else {
                                // For cities without dedicated pages (like Seoul)
                                CityGridItem(
                                    imageName: gridImages[index],
                                    cityName: cityName,
                                    activityText: gridActs[index]
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // London Page Overlay
            if showLondonPage {
                LondonPage()
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity), 
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                    .zIndex(1)
                    .onReceive(NotificationCenter.default.publisher(for: .dismissLondonPage)) { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showLondonPage = false
                        }
                    }
            }
            
            // Prague Page Overlay
            if showPraguePage {
                PraguePage()
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity), 
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                    .zIndex(1)
                    .onReceive(NotificationCenter.default.publisher(for: .dismissPraguePage)) { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showPraguePage = false
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .animation(.easeInOut(duration: 0.2), value: showLondonPage)
        .animation(.easeInOut(duration: 0.2), value: showPraguePage)
    }
}

// Notification names for dismissing pages
extension Notification.Name {
    static let dismissLondonPage = Notification.Name("dismissLondonPage")
    static let dismissPraguePage = Notification.Name("dismissPraguePage")
}

// Helper view for city grid items
struct CityGridItem: View {
    let imageName: String
    let cityName: String
    let activityText: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 105)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(cityName) // Dynamic city name
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: -14, y: -75)
            
            Text(activityText) // Dynamic activity text
                .font(.system(size: 10))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 14, y: -8)
        }
    }
}

#Preview {
    ProfilePage1()
        .environmentObject(AuthViewModel())
}
