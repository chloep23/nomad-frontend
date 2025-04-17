import Foundation

struct AuthResponse: Codable {
    let message: String?
    let userId: String?
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case userId
        case token
    }
}

struct User: Codable {
    let userId: String
    let email: String
    let joinDate: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case email
        case joinDate = "join_date"
    }
}
