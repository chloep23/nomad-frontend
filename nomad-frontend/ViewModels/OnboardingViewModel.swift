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
    
    // Validation error messages for each step
    @Published var nameError: String?
    @Published var usernameError: String?
    @Published var dateOfBirthError: String?
    @Published var homeCityError: String?
    @Published var activitiesError: String?
    
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
        // Don't validate immediately - let the UI handle validation when needed
    }
    
    func validateStep1() -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty {
            Task { @MainActor in
                self.nameError = "Name is required"
            }
            return false
        }
        
        if trimmedName.count < 2 {
            Task { @MainActor in
                self.nameError = "Name must be at least 2 characters"
            }
            return false
        }
        
        if trimmedName.count > 50 {
            Task { @MainActor in
                self.nameError = "Name must be less than 50 characters"
            }
            return false
        }
        
        // Check if name contains only letters, spaces, hyphens, and apostrophes
        let nameRegex = "^[a-zA-Z\\s\\-']+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        if !namePredicate.evaluate(with: trimmedName) {
            Task { @MainActor in
                self.nameError = "Name can only contain letters, spaces, hyphens, and apostrophes"
            }
            return false
        }
        
        // Clear error if validation passes
        Task { @MainActor in
            self.nameError = nil
        }
        return true
    }
    
    func validateStep2() -> Bool {
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedUsername.isEmpty {
            Task { @MainActor in
                self.usernameError = "Username is required"
            }
            return false
        }
        
        if trimmedUsername.count < 3 {
            Task { @MainActor in
                self.usernameError = "Username must be at least 3 characters"
            }
            return false
        }
        
        if trimmedUsername.count > 20 {
            Task { @MainActor in
                self.usernameError = "Username must be less than 20 characters"
            }
            return false
        }
        
        // Check if username contains only alphanumeric characters, underscores, and periods
        let usernameRegex = "^[a-zA-Z0-9._]+$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        if !usernamePredicate.evaluate(with: trimmedUsername) {
            Task { @MainActor in
                self.usernameError = "Username can only contain letters, numbers, periods, and underscores"
            }
            return false
        }
        
        // Check if username starts with a letter or number
        if let firstChar = trimmedUsername.first {
            if !firstChar.isLetter && !firstChar.isNumber {
                Task { @MainActor in
                    self.usernameError = "Username must start with a letter or number"
                }
                return false
            }
        }
        
        // Clear error if validation passes
        Task { @MainActor in
            self.usernameError = nil
        }
        return true
    }
    
    func validateStep3() -> Bool {
        let trimmedDate = dateOfBirth.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedDate.isEmpty {
            Task { @MainActor in
                self.dateOfBirthError = "Date of birth is required"
            }
            return false
        }
        
        // Validate date format (MM/dd/yyyy)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.isLenient = false
        
        guard let date = dateFormatter.date(from: trimmedDate) else {
            Task { @MainActor in
                self.dateOfBirthError = "Please enter a valid date in MM/dd/yyyy format"
            }
            return false
        }
        
        // Check if user is at least 13 years old
        let calendar = Calendar.current
        let thirteenYearsAgo = calendar.date(byAdding: .year, value: -13, to: Date()) ?? Date()
        
        if date > thirteenYearsAgo {
            Task { @MainActor in
                self.dateOfBirthError = "You must be at least 13 years old to use this app"
            }
            return false
        }
        
        // Check if date is not in the future
        if date > Date() {
            Task { @MainActor in
                self.dateOfBirthError = "Date of birth cannot be in the future"
            }
            return false
        }
        
        // Check if date is reasonable (not more than 120 years ago)
        let oneHundredTwentyYearsAgo = calendar.date(byAdding: .year, value: -120, to: Date()) ?? Date()
        if date < oneHundredTwentyYearsAgo {
            Task { @MainActor in
                self.dateOfBirthError = "Please enter a valid date of birth"
            }
            return false
        }
        
        // Clear error if validation passes
        Task { @MainActor in
            self.dateOfBirthError = nil
        }
        return true
    }
    
    func validateStep4() -> Bool {
        let trimmedCity = homeCity.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedCity.isEmpty {
            Task { @MainActor in
                self.homeCityError = "Home city is required"
            }
            return false
        }
        
        if trimmedCity.count < 2 {
            Task { @MainActor in
                self.homeCityError = "City name must be at least 2 characters"
            }
            return false
        }
        
        if trimmedCity.count > 50 {
            Task { @MainActor in
                self.homeCityError = "City name must be less than 50 characters"
            }
            return false
        }
        
        // Check if city contains only letters, spaces, hyphens, apostrophes, and periods
        let cityRegex = "^[a-zA-Z\\s\\-'.]+$"
        let cityPredicate = NSPredicate(format: "SELF MATCHES %@", cityRegex)
        if !cityPredicate.evaluate(with: trimmedCity) {
            Task { @MainActor in
                self.homeCityError = "City name can only contain letters, spaces, hyphens, apostrophes, and periods"
            }
            return false
        }
        
        // Clear error if validation passes
        Task { @MainActor in
            self.homeCityError = nil
        }
        return true
    }
    
    func validateStep5() -> Bool {
        if selectedActivities.isEmpty {
            Task { @MainActor in
                self.activitiesError = "Please select at least one activity"
            }
            return false
        }
        
        // Clear error if validation passes
        Task { @MainActor in
            self.activitiesError = nil
        }
        return true
    }
    
    func completeOnboarding() {
        guard let userId = TokenManager.shared.getUserId() else {
            errorMessage = "User not found. Please log in again."
            return
        }
        
        guard validateStep1(), validateStep2(), validateStep3(), validateStep4(), validateStep5() else {
            errorMessage = "Please fix all validation errors before continuing."
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
    
    // Helper function to get available activities
    func getAvailableActivities() -> [String] {
        return availableActivities
    }
    
    // Helper function to clear all errors safely
    func clearErrors() {
        Task { @MainActor in
            self.nameError = nil
            self.usernameError = nil
            self.dateOfBirthError = nil
            self.homeCityError = nil
            self.activitiesError = nil
            self.errorMessage = nil
        }
    }
    
    // Safe error clearing functions for individual fields
    func clearNameError() {
        Task { @MainActor in
            self.nameError = nil
        }
    }
    
    func clearUsernameError() {
        Task { @MainActor in
            self.usernameError = nil
        }
    }
    
    func clearDateOfBirthError() {
        Task { @MainActor in
            self.dateOfBirthError = nil
        }
    }
    
    func clearHomeCityError() {
        Task { @MainActor in
            self.homeCityError = nil
        }
    }
    
    func clearActivitiesError() {
        Task { @MainActor in
            self.activitiesError = nil
        }
    }
} 