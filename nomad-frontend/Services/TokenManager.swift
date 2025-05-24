import Foundation
import Security

class TokenManager {
    static let shared = TokenManager()
    
    private let tokenKey = "com.nomad.auth.token"
    private let userIdKey = "com.nomad.auth.userId"
    private let onboardingKey = "com.nomad.auth.onboardingComplete"
    
    private init() {}
    
    // Store token securely in the Keychain
    func saveToken(_ token: String) -> Bool {
        let tokenData = Data(token.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: tokenData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        // Delete any existing token first
        SecItemDelete(query as CFDictionary)
        
        // Add the new token
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    // Retrieve token from Keychain
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data,
              let token = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return token
    }
    
    // Delete token
    func deleteToken() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
    
    // Save userId in UserDefaults (not sensitive like the token)
    func saveUserId(_ userId: String) {
        UserDefaults.standard.set(userId, forKey: userIdKey)
    }
    
    // Get userId from UserDefaults
    func getUserId() -> String? {
        return UserDefaults.standard.string(forKey: userIdKey)
    }
    
    // Clear userId
    func clearUserId() {
        UserDefaults.standard.removeObject(forKey: userIdKey)
    }
    
    // MARK: - Onboarding Status Management
    
    // Save onboarding completion status
    func saveOnboardingComplete(_ isComplete: Bool) {
        UserDefaults.standard.set(isComplete, forKey: onboardingKey)
    }
    
    // Get onboarding completion status
    func isOnboardingComplete() -> Bool {
        return UserDefaults.standard.bool(forKey: onboardingKey)
    }
    
    // Clear onboarding status (useful for logout or reset)
    func clearOnboardingStatus() {
        UserDefaults.standard.removeObject(forKey: onboardingKey)
    }
}
