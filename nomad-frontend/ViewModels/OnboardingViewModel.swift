import Foundation
import SwiftUI

@MainActor
class OnboardingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var dateOfBirth: String = ""
    @Published var homeCity: String = ""
    @Published var selectedActivities: Set<String> = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var onboardingComplete = false
    
    private let availableActivities = [
        "Landmarks", "Shopping", "Nature", "Museum", 
        "Nightlife", "Art", "Entertainment", "Sports", "Other"
    ]
    
    func toggleActivity(_ activity: String) {
        if selectedActivities.contains(activity) {
            selectedActivities.remove(activity)
        } else {
            selectedActivities.insert(activity)
        }
    }
    
    func validateStep1() -> Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func validateStep2() -> Bool {
        return !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func validateStep3() -> Bool {
        // Basic date validation - you might want more sophisticated validation
        return !dateOfBirth.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func validateStep4() -> Bool {
        return !homeCity.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func completeOnboarding() {
        guard let userId = TokenManager.shared.getUserId() else {
            errorMessage = "User not found. Please log in again."
            return
        }
        
        guard validateStep1(), validateStep2(), validateStep3(), validateStep4() else {
            errorMessage = "Please fill in all required fields."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let request = OnboardingRequest(
                    userId: userId,
                    name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                    username: username.trimmingCharacters(in: .whitespacesAndNewlines),
                    dateOfBirth: convertDateFormat(dateOfBirth),
                    homeCity: homeCity.trimmingCharacters(in: .whitespacesAndNewlines),
                    activities: Array(selectedActivities)
                )
                
                let response = try await APIService.shared.completeOnboarding(request)
                self.onboardingComplete = true
                self.isLoading = false
                
                // Save onboarding completion status locally
                TokenManager.shared.saveOnboardingComplete(true)
                
                print("Onboarding completed: \(response.message)")
                
            } catch let error as APIError {
                self.isLoading = false
                
                switch error {
                case .unauthorized:
                    self.errorMessage = "Please log in again"
                case .serverError(let message):
                    self.errorMessage = message
                default:
                    self.errorMessage = "Failed to complete onboarding"
                }
            } catch {
                self.isLoading = false
                self.errorMessage = "An unexpected error occurred"
            }
        }
    }
    
    private func convertDateFormat(_ dateString: String) -> String {
        // Convert from MM/dd/yyyy to yyyy-MM-dd format for backend
        let components = dateString.split(separator: "/")
        if components.count == 3 {
            let month = String(format: "%02d", Int(components[0]) ?? 1)
            let day = String(format: "%02d", Int(components[1]) ?? 1)
            let year = String(components[2])
            return "\(year)-\(month)-\(day)"
        }
        return dateString // Return as-is if format is unexpected
    }
} 