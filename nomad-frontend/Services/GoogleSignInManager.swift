import Foundation
import UIKit
import GoogleSignIn

// Simplified Google Sign-In Manager for testing
// To enable full Google Sign-In functionality:
// 1. Add GoogleSignIn SDK to your project via SPM: https://github.com/google/GoogleSignIn-iOS
// 2. Add GoogleService-Info.plist to your project
// 3. Uncomment the full implementation below

class GoogleSignInManager: NSObject, ObservableObject {
    static let shared = GoogleSignInManager()
    
    private override init() {
        super.init()
        setupGoogleSignIn()
    }
    
    private func setupGoogleSignIn() {
        // Use the NEW client ID that matches your Lambda function
        let clientId = "238015801810-o9vqghkjh2aak9cihb3veb0a56p9do5j.apps.googleusercontent.com"
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientId)
    }
    
    @MainActor
    func signIn() async throws -> String {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let presentingViewController = windowScene.windows.first?.rootViewController else {
            throw GoogleSignInError.noPresentingViewController
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString else {
                    continuation.resume(throwing: GoogleSignInError.noIdToken)
                    return
                }
                
                continuation.resume(returning: idToken)
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}


// Full implementation with Google Sign-In SDK (uncomment when SDK is added):

// import GoogleSignIn

// class GoogleSignInManager: NSObject, ObservableObject {
//     static let shared = GoogleSignInManager()
    
//     private override init() {
//         super.init()
//         setupGoogleSignIn()
//     }
    
//     private func setupGoogleSignIn() {
//         // Configure Google Sign-In with your client ID
//         guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
//               let plist = NSDictionary(contentsOfFile: path),
//               let clientId = plist["CLIENT_ID"] as? String else {
//             print("GoogleService-Info.plist not found or CLIENT_ID missing")
//             return
//         }
        
//         GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientId)
//     }
    
//     func signIn() async throws -> String {
//         guard let presentingViewController = await UIApplication.shared.windows.first?.rootViewController else {
//             throw GoogleSignInError.noPresentingViewController
//         }
        
//         return try await withCheckedThrowingContinuation { continuation in
//             GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
//                 if let error = error {
//                     continuation.resume(throwing: error)
//                     return
//                 }
                
//                 guard let user = result?.user,
//                       let idToken = user.idToken?.tokenString else {
//                     continuation.resume(throwing: GoogleSignInError.noIdToken)
//                     return
//                 }
                
//                 continuation.resume(returning: idToken)
//             }
//         }
//     }
    
//     func signOut() {
//         GIDSignIn.sharedInstance.signOut()
//     }
// }


enum GoogleSignInError: Error, LocalizedError {
    case noPresentingViewController
    case noIdToken
    
    var errorDescription: String? {
        switch self {
        case .noPresentingViewController:
            return "Could not find a presenting view controller"
        case .noIdToken:
            return "Failed to get ID token from Google"
        }
    }
} 
