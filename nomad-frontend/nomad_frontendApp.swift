//
//  testnomadApp.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        OnboardingFlow()
    }
}

@main
struct nomad_frontendApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if !authViewModel.isAuthenticated {
                    // Show login or create account
                    LoginPage()
                        .environmentObject(authViewModel)
                } else if !authViewModel.hasCompletedOnboarding {
                    // Show onboarding flow
                    OnboardingFlow()
                        .environmentObject(authViewModel)
                } else {
                    // Show main app
                    MainTabView()
                        .environmentObject(authViewModel)
                }
            }
        }
    }
}
