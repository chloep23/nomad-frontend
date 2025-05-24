import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var appStateManager: AppStateManager?
    
    init() {
        // AppStateManager will be injected from the environment
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
                if let userId = response.userId {
                    TokenManager.shared.saveUserId(userId)
                }
                
                self.isLoading = false
                
                // Notify AppStateManager about successful authentication
                if let userId = response.userId {
                    appStateManager?.login(token: response.token, userId: userId)
                }
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
                if let userId = response.userId {
                    TokenManager.shared.saveUserId(userId)
                }
                
                self.isLoading = false
                
                // Notify AppStateManager about successful authentication
                if let userId = response.userId {
                    appStateManager?.login(token: response.token, userId: userId)
                }
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
    
    func logout() {
        appStateManager?.logout()
    }
}
