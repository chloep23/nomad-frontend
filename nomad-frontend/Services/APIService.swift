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
}