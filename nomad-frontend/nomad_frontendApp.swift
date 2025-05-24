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
    @StateObject var appStateManager = AppStateManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appStateManager.isLoading {
                    // Show loading screen while checking app state
                    LoadingPage()
                } else if !appStateManager.isAuthenticated {
                    // Show login or create account
                    LoginPage()
                        .environmentObject(appStateManager)
                } else if !appStateManager.hasCompletedOnboarding {
                    // Show onboarding flow
                    OnboardingFlow()
                        .environmentObject(appStateManager)
                } else {
                    // Show main app
                    MainTabView()
                        .environmentObject(appStateManager)
                }
            }
        }
    }
}
