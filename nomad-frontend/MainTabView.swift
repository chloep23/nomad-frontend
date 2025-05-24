//
//  MainTabView.swift
//  nomad-frontend
//

import SwiftUI

struct MainTabView: View {
    @State private var currentTab: NavigationTab = .home
    
    var body: some View {
        VStack {
            // Main content area
            Group {
                switch currentTab {
                case .home:
                    HomePage()
                case .feed:
                    FeedPage()
                case .log:
                    LogPlaceholderView()
                case .saved:
                    SavedPlaceholderView()
                case .profile:
                    ProfilePage1()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Bottom Navigation Bar
            BottomNavigationBar(currentTab: currentTab) { selectedTab in
                currentTab = selectedTab
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Updated placeholder views without bottom navigation bar (since it's now managed by MainTabView)
struct LogPlaceholderView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Log Page")
                .font(.largeTitle)
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
            Text("Coming Soon...")
                .font(.title2)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
    }
}

struct SavedPlaceholderView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Saved Page")
                .font(.largeTitle)
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
            Text("Coming Soon...")
                .font(.title2)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
    }
}

#Preview {
    MainTabView()
} 