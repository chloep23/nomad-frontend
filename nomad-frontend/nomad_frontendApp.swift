//
//  testnomadApp.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Onboarding1()
    }
}

@main
struct nomad_frontendApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                // This would be your main app after login
                // For now, let's start with the onboarding process
                Onboarding1()
                    .environmentObject(authViewModel)
            } else {
                // Show login or create account
                LoginPage()
                    .environmentObject(authViewModel)
            }
        }
    }
}
