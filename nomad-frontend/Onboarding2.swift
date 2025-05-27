//
//  Onboarding2.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct Onboarding2: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    var onNext: () -> Void
    var onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Top section with back button and image
            HStack {
                Button(action: {
                    onBack()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .frame(width: 20, height: 16)
                }
                .padding(.leading, 30)
                .padding(.top, 180)
                
                Spacer()
                
                Image("traveling")
                    .resizable()
                    .frame(width: 55, height: 55)
                    .padding(.trailing, 30)
                    .padding(.top, 180)
            }
            
            // Centered "Step 2" title
            HStack {
                Spacer()
                Text("Step 2")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                Spacer()
            }
            .padding(.top, 20)
            
            // Main title
            HStack {
                Text("What's your ID?")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                    .padding(.leading, 40)
                Spacer()
            }
            .padding(.top, 15)
            
            // Input section
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .leading) {
                    if onboardingViewModel.username.isEmpty {
                        Text("Your username")
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.45))
                            .offset(x: 18)
                            .allowsHitTesting(false)
                    }
                    
                    TextField("", text: $onboardingViewModel.username)
                        .padding(.horizontal, 15)
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .frame(width: 300, height: 37)
                        .background(Color.clear)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onChange(of: onboardingViewModel.username) { _, _ in
                            // Clear error when user starts typing
                            if onboardingViewModel.usernameError != nil {
                                onboardingViewModel.clearUsernameError()
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(onboardingViewModel.usernameError != nil ? .red : .black.opacity(0.45))
                                .shadow(color: .black.opacity(0.8), radius: 2, x: -2, y: 4)
                        )
                }
                
                // Error message
                if let usernameError = onboardingViewModel.usernameError {
                    Text(usernameError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 18)
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 30)
            
            // Helper text
            VStack(alignment: .leading, spacing: 4) {
                Text("Choose a unique username")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("• 3-20 characters")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text("• Letters, numbers, periods, and underscores only")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text("• Must start with a letter or number")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 40)
            .padding(.top, 15)
            
            // Next button
            HStack {
                Spacer()
                Button(action: {
                    if onboardingViewModel.validateStep2() {
                        onNext()
                    }
                }) {
                    HStack {
                        Text("Next")
                            .offset(x: -9)
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 17, height: 13)
                            .offset(x: 3)
                    }
                    .bold()
                    .font(.system(size: 17))
                    .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                    .frame(width: 108, height: 32)
                    .background(canProceed() ? Color(red: 4/255, green: 57/255, blue: 11/255) : Color.gray)
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                }
                .disabled(!canProceed())
                .padding(.trailing, 30)
            }
            .padding(.top, 40)
            
            Spacer()
            
            // Dots indicator
            HStack {
                Spacer()
                Image("5dots2")
                    .resizable()
                    .frame(width: 120, height: 12)
                Spacer()
            }
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
        .navigationBarHidden(true)
        .onAppear {
            // Clear any previous errors when the view appears
            onboardingViewModel.clearUsernameError()
        }
    }
    
    // Simple check that doesn't trigger validation
    private func canProceed() -> Bool {
        let trimmed = onboardingViewModel.username.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count >= 3
    }
}

#Preview {
    NavigationStack {
        Onboarding2(onboardingViewModel: OnboardingViewModel(), onNext: {}, onBack: {})
    }
}
