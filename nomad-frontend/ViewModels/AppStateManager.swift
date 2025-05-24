import Foundation
import SwiftUI

@MainActor
class AppStateManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var hasCompletedOnboarding = false
    @Published var isLoading = true
    
    init() {
        checkAppState()
    }
    
    func checkAppState() {
        isLoading = true
        
        // Check if user has a valid token
        isAuthenticated = TokenManager.shared.getToken() != nil
        
        // Check if user has completed onboarding
        hasCompletedOnboarding = TokenManager.shared.isOnboardingComplete()
        
        // If authenticated, try to get user profile to verify onboarding status from server
        if isAuthenticated {
            Task {
                await verifyOnboardingStatusFromServer()
                self.isLoading = false
            }
        } else {
            isLoading = false
        }
    }
    
    private func verifyOnboardingStatusFromServer() async {
        do {
            let profile = try await APIService.shared.getUserProfile()
            
            // Update local onboarding status based on server response
            if let serverOnboardingStatus = profile.isOnboardingComplete {
                hasCompletedOnboarding = serverOnboardingStatus
                TokenManager.shared.saveOnboardingComplete(serverOnboardingStatus)
            }
        } catch {
            // If we can't fetch profile, keep local status
            print("Could not verify onboarding status from server: \(error)")
        }
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        TokenManager.shared.saveOnboardingComplete(true)
    }
    
    func logout() {
        isAuthenticated = false
        hasCompletedOnboarding = false
        TokenManager.shared.deleteToken()
        TokenManager.shared.clearUserId()
        TokenManager.shared.clearOnboardingStatus()
    }
    
    func login(token: String, userId: String) {
        TokenManager.shared.saveToken(token)
        TokenManager.shared.saveUserId(userId)
        isAuthenticated = true
        
        // Check onboarding status after login
        Task {
            await verifyOnboardingStatusFromServer()
        }
    }
} 