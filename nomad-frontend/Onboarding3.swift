//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct Onboarding3: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    var onNext: () -> Void
    var onBack: () -> Void
    @State private var dateInput: String = ""
    
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
            
            // Centered "Step 3" title
            HStack {
                Spacer()
                Text("Step 3")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                Spacer()
            }
            .padding(.top, 20)
            
            // Main title
            HStack {
                Text("How old are you?")
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
                    if dateInput.isEmpty {
                        Text("MM/DD/YYYY")
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.45))
                            .offset(x: 18)
                            .allowsHitTesting(false)
                    }
                    
                    TextField("", text: $dateInput)
                        .padding(.horizontal, 15)
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .frame(width: 300, height: 37)
                        .background(Color.clear)
                        .keyboardType(.numberPad)
                        .onChange(of: dateInput) { _, newValue in
                            let formatted = formatDateInput(newValue)
                            if formatted != newValue {
                                dateInput = formatted
                            }
                            onboardingViewModel.dateOfBirth = formatted
                            
                            // Clear error when user starts typing
                            if onboardingViewModel.dateOfBirthError != nil {
                                onboardingViewModel.clearDateOfBirthError()
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(onboardingViewModel.dateOfBirthError != nil ? .red : .black.opacity(0.45))
                                .shadow(color: .black.opacity(0.8), radius: 2, x: -2, y: 4)
                        )
                }
                
                // Error message
                if let dateOfBirthError = onboardingViewModel.dateOfBirthError {
                    Text(dateOfBirthError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 18)
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 30)
            
            // Helper text
            Text("Enter your date of birth (numbers only)")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.leading, 40)
                .padding(.top, 15)
            
            // Next button
            HStack {
                Spacer()
                Button(action: {
                    if onboardingViewModel.validateStep3() {
                        onNext()
                    }
                }) {
                    HStack{
                        Text("Next")
                            .offset(x:-9)
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 17, height:13)
                            .offset(x:3)
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
                Image("5dots3")
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
            // Initialize with existing value if any
            dateInput = onboardingViewModel.dateOfBirth
            // Clear any previous errors
            onboardingViewModel.clearDateOfBirthError()
        }
    }
    
    // Simple check that doesn't trigger validation
    private func canProceed() -> Bool {
        return dateInput.count == 10 // MM/DD/YYYY format
    }
    
    // Auto-format date input with slashes
    private func formatDateInput(_ input: String) -> String {
        // Remove any non-numeric characters except slashes
        let numbersOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Limit to 8 digits (MMDDYYYY)
        let limitedNumbers = String(numbersOnly.prefix(8))
        
        var formatted = ""
        for (index, character) in limitedNumbers.enumerated() {
            if index == 2 || index == 4 {
                formatted += "/"
            }
            formatted += String(character)
        }
        
        return formatted
    }
}

#Preview {
    NavigationStack {
        Onboarding3(onboardingViewModel: OnboardingViewModel(), onNext: {}, onBack: {})
    }
}
