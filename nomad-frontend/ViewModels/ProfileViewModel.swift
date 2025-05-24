import Foundation
import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    @Published var travelEntries: [TravelEntry] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadUserProfile() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let profile = try await APIService.shared.getUserProfile()
                self.userProfile = profile
                self.isLoading = false
            } catch let error as APIError {
                self.isLoading = false
                
                switch error {
                case .unauthorized:
                    self.errorMessage = "Please log in again"
                case .serverError(let message):
                    self.errorMessage = message
                default:
                    self.errorMessage = "Failed to load profile"
                }
            } catch {
                self.isLoading = false
                self.errorMessage = "An unexpected error occurred"
            }
        }
    }
    
    func loadTravelEntries() {
        Task {
            do {
                let entries = try await APIService.shared.getUserTravelEntries()
                self.travelEntries = entries
            } catch {
                print("Failed to load travel entries: \(error)")
            }
        }
    }
    
    func updateProfile(name: String, username: String, location: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let request = ProfileUpdateRequest(
                    name: name,
                    username: username,
                    location: location,
                    profilePicture: nil as String?
                )
                
                try await APIService.shared.updateUserProfile(request)
                
                // Reload profile after update
                loadUserProfile()
            } catch {
                self.isLoading = false
                self.errorMessage = "Failed to update profile"
            }
        }
    }
    
    func logout() {
        // Clear authentication token
        _ = TokenManager.shared.deleteToken()
        
        // Clear user ID
        TokenManager.shared.clearUserId()
        
        // Clear onboarding status
        TokenManager.shared.clearOnboardingStatus()
        
        // Clear profile data
        userProfile = nil as UserProfile?
        travelEntries = []
        errorMessage = nil as String?
        
        // Note: In a real app, you might want to navigate back to login screen
        // This would typically be handled by a parent view or app coordinator
        print("User logged out successfully")
    }
} 