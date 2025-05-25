import Foundation

struct AuthResponse: Codable {
    let message: String?
    let userId: String?
    let token: String
    let user: AuthUser? // For social auth responses (Google/Apple)
    
    // Computed property to get userId from either direct field or user object
    var effectiveUserId: String? {
        return userId ?? user?.userId
    }
    
    enum CodingKeys: String, CodingKey {
        case message
        case userId
        case token
        case user
    }
}

// Generic auth user object for social sign-in (Google/Apple)
struct AuthUser: Codable {
    let userId: String
    let email: String
    let name: String
    let profilePicture: String?
    
    enum CodingKeys: String, CodingKey {
        case userId
        case email
        case name
        case profilePicture = "profile_picture"
    }
}

// Legacy Google auth user object (keeping for backward compatibility)
struct GoogleUser: Codable {
    let userId: String
    let email: String
    let name: String
    let profilePicture: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case email
        case name
        case profilePicture = "profile_picture"
    }
}

// Updated User model with onboarding information
struct User: Codable {
    let userId: String
    let email: String
    let joinDate: String
    let name: String?
    let username: String?
    let dateOfBirth: String?
    let homeCity: String?
    let activities: [String]?
    let authType: String?
    let profilePicture: String?
    let isOnboardingComplete: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userId
        case email
        case joinDate = "join_date"
        case name
        case username
        case dateOfBirth
        case homeCity
        case activities
        case authType = "auth_type"
        case profilePicture = "profile_picture"
        case isOnboardingComplete = "is_onboarding_complete"
    }
}

// Onboarding Models
struct OnboardingRequest: Codable {
    let userId: String
    let name: String
    let username: String
    let dateOfBirth: String
    let homeCity: String
    let activities: [String]
}

struct OnboardingResponse: Codable {
    let message: String
    let userId: String
}

// Profile Models
struct UserProfile: Codable {
    let userId: String
    let email: String
    let name: String?
    let username: String?
    let dateOfBirth: String?
    let homeCity: String?
    let activities: [String]?
    let profilePicture: String?
    let joinDate: String
    let isOnboardingComplete: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userId
        case email
        case name
        case username
        case dateOfBirth
        case homeCity
        case activities
        case profilePicture = "profile_picture"
        case joinDate = "join_date"
        case isOnboardingComplete = "is_onboarding_complete"
    }
}

struct ProfileUpdateRequest: Codable {
    let name: String?
    let username: String?
    let location: String?
    let profilePicture: String?
}

// Travel Entry Models
struct TravelEntry: Codable {
    let id: String
    let userId: String
    let destination: String
    let startDate: String
    let endDate: String
    let description: String?
    let photos: [String]?
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case destination
        case startDate = "start_date"
        case endDate = "end_date"
        case description
        case photos
        case createdAt = "created_at"
    }
}
