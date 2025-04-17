import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var userId: String?
    
    init() {
        // Check if user is already authenticated
        if TokenManager.shared.getToken() != nil {
            self.isAuthenticated = true
            self.userId = TokenManager.shared.getUserId()
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
                if let userId = response.userId {
                    TokenManager.shared.saveUserId(userId)
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isAuthenticated = true
                    self.userId = response.userId
                }
            } catch let error as APIError {
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    switch error {
                    case .unauthorized:
                        self.errorMessage = "Invalid email or password"
                    case .serverError(let message):
                        self.errorMessage = message
                    default:
                        self.errorMessage = "Something went wrong. Please try again."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "An unexpected error occurred"
                }
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
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isAuthenticated = true
                    self.userId = response.userId
                }
            } catch let error as APIError {
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    switch error {
                    case .serverError(let message):
                        self.errorMessage = message
                    default:
                        self.errorMessage = "Something went wrong. Please try again."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "An unexpected error occurred"
                }
            }
        }
    }
    
    func logout() {
        _ = TokenManager.shared.deleteToken()
        TokenManager.shared.clearUserId()
        
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.userId = nil
        }
    }
}
