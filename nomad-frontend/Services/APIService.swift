import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
    case serverError(String)
    case unauthorized
}

class APIService {
    static let shared = APIService()
    
    // Your API Gateway URL
    private let baseURL = APIConfig.AWS_API_URL
    
    private init() {}
    
    // MARK: - Authentication Methods
    
    func register(email: String, password: String) async throws -> AuthResponse {
        let endpoint = "\(baseURL)/register"
        let body: [String: Any] = ["email": email, "password": password]
        
        let data = try await sendRequest(to: endpoint, method: "POST", body: body)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AuthResponse.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    func login(email: String, password: String) async throws -> AuthResponse {
        let endpoint = "\(baseURL)/login"
        let body: [String: Any] = ["email": email, "password": password]
        
        let data = try await sendRequest(to: endpoint, method: "POST", body: body)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AuthResponse.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    func googleAuth(idToken: String) async throws -> AuthResponse {
        let endpoint = "\(baseURL)/google"
        let body: [String: Any] = ["idToken": idToken]
        
        let data = try await sendRequest(to: endpoint, method: "POST", body: body)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AuthResponse.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    func appleAuth(result: AppleSignInResult) async throws -> AuthResponse {
        let endpoint = "\(baseURL)/apple"
        
        let body: [String: Any] = [
            "identityToken": result.identityToken,
            "authorizationCode": result.authorizationCode,
            "email": result.email ?? "",
            "fullName": [
                "givenName": result.fullName?.givenName ?? "",
                "familyName": result.fullName?.familyName ?? ""
            ],
            "nonce": result.nonce
        ]
        
        // 🐛 DEBUG: Print the request details
        print("🍎 DEBUG: Apple Auth Request Details:")
        print("🍎 DEBUG: Endpoint: \(endpoint)")
        print("🍎 DEBUG: Request body keys: \(body.keys)")
        print("🍎 DEBUG: Identity token length: \(result.identityToken.count)")
        print("🍎 DEBUG: Auth code length: \(result.authorizationCode.count)")
        print("🍎 DEBUG: Email: \(result.email ?? "nil")")
        print("🍎 DEBUG: Nonce: \(result.nonce)")
        
        let data = try await sendRequestWithDebug(to: endpoint, method: "POST", body: body)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AuthResponse.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    // MARK: - Profile Methods
    
    func getUserProfile() async throws -> UserProfile {
        let endpoint = "\(baseURL)/profile"
        let data = try await sendRequest(to: endpoint, method: "GET")
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(UserProfile.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    func updateUserProfile(_ request: ProfileUpdateRequest) async throws {
        let endpoint = "\(baseURL)/updateUser"
        
        let body: [String: Any] = [
            "name": request.name,
            "username": request.username,
            "location": request.location,
            "profilePicture": request.profilePicture
        ].compactMapValues { $0 }
        
        _ = try await sendRequest(to: endpoint, method: "PUT", body: body)
    }
    
    func getUserTravelEntries() async throws -> [TravelEntry] {
        let endpoint = "\(baseURL)/travel-entries"
        let data = try await sendRequest(to: endpoint, method: "GET")
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([TravelEntry].self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    // MARK: - Onboarding Methods
    
    func completeOnboarding(_ request: OnboardingRequest) async throws -> OnboardingResponse {
        let endpoint = "\(baseURL)/onboard"
        
        let body: [String: Any] = [
            "userId": request.userId,
            "name": request.name,
            "username": request.username,
            "dateOfBirth": request.dateOfBirth,
            "homeCity": request.homeCity,
            "activities": request.activities
        ]
        
        let data = try await sendRequest(to: endpoint, method: "POST", body: body)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(OnboardingResponse.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    // MARK: - Helper Methods
    
    private func sendRequest(to endpoint: String, method: String, body: [String: Any]? = nil) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Add auth token if available
        if let token = TokenManager.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Add body if provided
        if let body = body {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return data
            case 401:
                throw APIError.unauthorized
            default:
                // Try to extract error message from response
                if let errorJson = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let errorMessage = errorJson["error"] as? String {
                    throw APIError.serverError(errorMessage)
                } else {
                    throw APIError.serverError("Server error: \(httpResponse.statusCode)")
                }
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    // Enhanced debugging version of sendRequest
    private func sendRequestWithDebug(to endpoint: String, method: String, body: [String: Any]? = nil) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Add auth token if available
        if let token = TokenManager.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Add body if provided
        if let body = body {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            // 🐛 DEBUG: Print response details
            print("🍎 DEBUG: Response Status Code: \(httpResponse.statusCode)")
            print("🍎 DEBUG: Response Headers: \(httpResponse.allHeaderFields)")
            
            // Always try to parse the response body for debugging
            if let responseString = String(data: data, encoding: .utf8) {
                print("🍎 DEBUG: Raw Response Body: \(responseString)")
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return data
            case 401:
                throw APIError.unauthorized
            default:
                // Try to extract detailed error message from response
                if let errorJson = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print("🍎 DEBUG: Error JSON: \(errorJson)")
                    
                    // Look for diagnostic information
                    if let diagnostic = errorJson["diagnostic"] as? [String: Any] {
                        print("🍎 DEBUG: Diagnostic Info: \(diagnostic)")
                    }
                    
                    if let errorMessage = errorJson["error"] as? String {
                        throw APIError.serverError(errorMessage)
                    }
                }
                
                throw APIError.serverError("Server error: \(httpResponse.statusCode)")
            }
        } catch let error as APIError {
            throw error
        } catch {
            print("🍎 DEBUG: Network error: \(error)")
            throw APIError.networkError(error)
        }
    }
}