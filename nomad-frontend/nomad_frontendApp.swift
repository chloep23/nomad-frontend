//
//  testnomadApp.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI
import GoogleSignIn

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                if authViewModel.hasCompletedOnboarding {
                    MainTabView()
                } else {
                    OnboardingFlow()
                }
            } else {
                LoginPage()
            }
        }
    }
}

@main
struct nomad_frontendApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(onboardingViewModel)
                .onOpenURL { url in
                    print("📱 App received URL: \(url)")
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
