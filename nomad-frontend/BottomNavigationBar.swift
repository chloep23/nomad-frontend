//
//  BottomNavigationBar.swift
//  nomad-frontend
//

import SwiftUI

enum NavigationTab: String, CaseIterable {
    case home = "Home"
    case feed = "Feed"
    case log = "Log"
    case saved = "Saved"
    case profile = "Profile"
    
    var imageName: String {
        switch self {
        case .home: return "navhome"
        case .feed: return "navfeed"
        case .log: return "navlog"
        case .saved: return "navsaved"
        case .profile: return "navprofile"
        }
    }
    
    var index: Int {
        switch self {
        case .home: return 0
        case .feed: return 1
        case .log: return 2
        case .saved: return 3
        case .profile: return 4
        }
    }
}

struct BottomNavigationBar: View {
    let currentTab: NavigationTab
    let onTabTapped: ((NavigationTab) -> Void)?
    
    init(currentTab: NavigationTab, onTabTapped: ((NavigationTab) -> Void)? = nil) {
        self.currentTab = currentTab
        self.onTabTapped = onTabTapped
    }
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Spacer()
                
                // Home
                Button(action: {
                    onTabTapped?(.home)
                }) {
                    VStack(spacing: 4) {
                        Image("navhome")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .opacity(currentTab == .home ? 1.0 : 0.6)
                        
                        if currentTab == .home {
                            Circle()
                                .fill(Color(red: 4/255, green: 57/255, blue: 11/255))
                                .frame(width: 6, height: 6)
                        } else {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 6, height: 6)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // Feed
                Button(action: {
                    onTabTapped?(.feed)
                }) {
                    VStack(spacing: 4) {
                        Image("navfeed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .opacity(currentTab == .feed ? 1.0 : 0.6)
                        
                        if currentTab == .feed {
                            Circle()
                                .fill(Color(red: 4/255, green: 57/255, blue: 11/255))
                                .frame(width: 6, height: 6)
                        } else {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 6, height: 6)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // Log
                Button(action: {
                    onTabTapped?(.log)
                }) {
                    VStack(spacing: 4) {
                        Image("navlog")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .opacity(currentTab == .log ? 1.0 : 0.6)
                        
                        if currentTab == .log {
                            Circle()
                                .fill(Color(red: 4/255, green: 57/255, blue: 11/255))
                                .frame(width: 6, height: 6)
                        } else {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 6, height: 6)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // Saved
                Button(action: {
                    onTabTapped?(.saved)
                }) {
                    VStack(spacing: 4) {
                        Image("navsaved")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .opacity(currentTab == .saved ? 1.0 : 0.6)
                        
                        if currentTab == .saved {
                            Circle()
                                .fill(Color(red: 4/255, green: 57/255, blue: 11/255))
                                .frame(width: 6, height: 6)
                        } else {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 6, height: 6)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // Profile
                Button(action: {
                    onTabTapped?(.profile)
                }) {
                    VStack(spacing: 4) {
                        Image("navprofile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .opacity(currentTab == .profile ? 1.0 : 0.6)
                        
                        if currentTab == .profile {
                            Circle()
                                .fill(Color(red: 4/255, green: 57/255, blue: 11/255))
                                .frame(width: 6, height: 6)
                        } else {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 6, height: 6)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
            .padding(.vertical, 2)
            .offset(y: 6)
        }
    }
}

// Placeholder pages for Log and Saved until you create them
struct LogPlaceholderPage: View {
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
            
            BottomNavigationBar(currentTab: .log)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
        .navigationBarBackButtonHidden(true)
    }
}

struct SavedPlaceholderPage: View {
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
            
            BottomNavigationBar(currentTab: .saved)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
        .navigationBarBackButtonHidden(true)
    }
} 