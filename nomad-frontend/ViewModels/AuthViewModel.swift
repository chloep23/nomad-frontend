import Foundation
import SwiftUI

// Utility to safely handle potential NaN values
extension Double {
    func safeValue(default defaultValue: Double = 0.0) -> Double {
        return self.isNaN || self.isInfinite ? defaultValue : self
    }
}

extension CGFloat {
    func safeValue(default defaultValue: CGFloat = 0.0) -> CGFloat {
        return self.isNaN || self.isInfinite ? defaultValue : self
    }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var hasCompletedOnboarding = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        checkAuthState()
    }
    
    func checkAuthState() {
        // Check if user has a valid token
        isAuthenticated = TokenManager.shared.getToken() != nil
        
        // Check if user has completed onboarding locally
        hasCompletedOnboarding = TokenManager.shared.isOnboardingComplete()
        
        // If authenticated, verify onboarding status from server
        if isAuthenticated {
            Task {
                await verifyOnboardingStatusFromServer()
            }
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
        } catch let error as APIError {
            // Handle specific API errors more gracefully
            switch error {
            case .serverError(let message):
                print("Could not verify onboarding status from server: \(message)")
                // If it's a 404, the user profile might not exist yet
                // For new users, this is expected - keep local status
                if message.contains("404") {
                    print("User profile not found on server, using local onboarding status")
                }
            case .unauthorized:
                print("Unauthorized when verifying onboarding status - token may be invalid")
                // Consider logging out the user if token is invalid
                // logout()
            default:
                print("Could not verify onboarding status from server: \(error)")
            }
            // Keep local status when server verification fails
        } catch {
            // If we can't fetch profile, keep local status
            print("Could not verify onboarding status from server: \(error)")
        }
    }
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await APIService.shared.login(email: email, password: password)
                
                // Save token and userId
                _ = TokenManager.shared.saveToken(response.token)
                if let userId = response.effectiveUserId {
                    TokenManager.shared.saveUserId(userId)
                }
                
                self.isLoading = false
                self.isAuthenticated = true
                
                // Verify onboarding status from server after login
                await verifyOnboardingStatusFromServer()
                
            } catch let error as APIError {
                self.isLoading = false
                
                switch error {
                case .unauthorized:
                    self.errorMessage = "Invalid email or password"
                case .serverError(let message):
                    self.errorMessage = message
                default:
                    self.errorMessage = "Something went wrong. Please try again."
                }
            } catch {
                self.isLoading = false
                self.errorMessage = "An unexpected error occurred"
            }
        }
    }
    
    func register(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await APIService.shared.register(email: email, password: password)
                
                // Save token and userId
                _ = TokenManager.shared.saveToken(response.token)
                if let userId = response.effectiveUserId {
                    TokenManager.shared.saveUserId(userId)
                }
                
                self.isLoading = false
                self.isAuthenticated = true
                
                // New users haven't completed onboarding
                self.hasCompletedOnboarding = false
                TokenManager.shared.saveOnboardingComplete(false)
                
                // Note: Don't call verifyOnboardingStatusFromServer for new users
                // as their profile doesn't exist yet and will cause 404 errors
                
            } catch let error as APIError {
                self.isLoading = false
                
                switch error {
                case .serverError(let message):
                    self.errorMessage = message
                default:
                    self.errorMessage = "Something went wrong. Please try again."
                }
            } catch {
                self.isLoading = false
                self.errorMessage = "An unexpected error occurred"
            }
        }
    }
    
    func googleAuth(idToken: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await APIService.shared.googleAuth(idToken: idToken)
                
                // Save token and userId
                _ = TokenManager.shared.saveToken(response.token)
                if let userId = response.effectiveUserId {
                    TokenManager.shared.saveUserId(userId)
                }
                
                self.isLoading = false
                self.isAuthenticated = true
                
                // For Google users, check if they need onboarding
                // Since Google auth might return existing users, verify onboarding status
                await verifyOnboardingStatusFromServer()
                
            } catch let error as APIError {
                self.isLoading = false
                
                switch error {
                case .serverError(let message):
                    self.errorMessage = message
                case .unauthorized:
                    self.errorMessage = "Google authentication failed"
                default:
                    self.errorMessage = "Something went wrong with Google sign-in. Please try again."
                }
            } catch {
                self.isLoading = false
                self.errorMessage = "An unexpected error occurred during Google sign-in"
            }
        }
    }
    
    func appleAuth(result: AppleSignInResult) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await APIService.shared.appleAuth(result: result)
                
                // Save token and userId
                _ = TokenManager.shared.saveToken(response.token)
                if let userId = response.effectiveUserId {
                    TokenManager.shared.saveUserId(userId)
                }
                
                self.isLoading = false
                self.isAuthenticated = true
                
                // For Apple users, check if they need onboarding
                // Since Apple auth might return existing users, verify onboarding status
                await verifyOnboardingStatusFromServer()
                
            } catch let error as APIError {
                self.isLoading = false
                
                switch error {
                case .serverError(let message):
                    self.errorMessage = message
                case .unauthorized:
                    self.errorMessage = "Apple authentication failed"
                default:
                    self.errorMessage = "Something went wrong with Apple sign-in. Please try again."
                }
            } catch {
                self.isLoading = false
                self.errorMessage = "An unexpected error occurred during Apple sign-in"
            }
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
        errorMessage = nil
    }
}
