//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct Onboarding5: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    var onComplete: () -> Void
    var onBack: () -> Void
    @State private var selectedActivities: Set<String> = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top section with image
                
                HStack {
                    Spacer()
                    Image("traveling")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .padding(.trailing, 30)
                }
                .padding(.top, 180)
                
                // Centered "Final Step" title
                HStack {
                    Spacer()
                    Text("Final Step")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                    Spacer()
                }
                .padding(.top, 20)
                
                // Main title
                HStack {
                    Text("What do you like?")
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
                        .padding(.leading, 40)
                    Spacer()
                }
                .padding(.top, 15)
                
                // Category buttons section - centered
                VStack(spacing: 15) {
                    // First row
                    HStack(spacing: 10) {
                        Spacer()
                        CategoryButton(title: "Landmarks", width: 112, selectedActivities: $selectedActivities)
                        CategoryButton(title: "Shopping", width: 110, selectedActivities: $selectedActivities)
                        CategoryButton(title: "Nature", width: 80, selectedActivities: $selectedActivities)
                        Spacer()
                    }
                    
                    // Second row
                    HStack(spacing: 10) {
                        Spacer()
                        CategoryButton(title: "Museum", width: 90, selectedActivities: $selectedActivities)
                        CategoryButton(title: "Nightlife", width: 95, selectedActivities: $selectedActivities)
                        CategoryButton(title: "Art", width: 50, selectedActivities: $selectedActivities)
                        Spacer()
                    }
                    
                    // Third row
                    HStack(spacing: 10) {
                        Spacer()
                        CategoryButton(title: "Entertainment", width: 142, selectedActivities: $selectedActivities)
                        CategoryButton(title: "Sports", width: 80, selectedActivities: $selectedActivities)
                        CategoryButton(title: "Other", width: 80, selectedActivities: $selectedActivities)
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                // Error message
                if let errorMessage = onboardingViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                        .padding(.top, 10)
                }
                
                // Begin button
                HStack {
                    Spacer()
                    Button(action: {
                        onboardingViewModel.selectedActivities = selectedActivities
                        onboardingViewModel.completeOnboarding()
                        onComplete()
                    }) {
                        if onboardingViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 255/255, green: 248/255, blue: 228/255)))
                                .frame(width: 118, height: 30)
                                .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                                .cornerRadius(30)
                        } else {
                            HStack(spacing: 8) {
                                Text("Begin")
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 17, height: 13)
                            }
                            .bold()
                            .font(.system(size: 17))
                            .foregroundColor(Color(red: 255/255, green: 248/255, blue: 228/255))
                            .frame(width: 118, height: 30)
                            .background(Color(red: 4/255, green: 57/255, blue: 11/255))
                            .cornerRadius(30)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 5)
                        }
                    }
                    .disabled(onboardingViewModel.isLoading)
                    .padding(.trailing, 30)
                }
                .padding(.top, 40)
                
                Spacer()
                
                // Dots indicator
                HStack {
                    Spacer()
                    Image("5dots5")
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
                // Sync local selectedActivities with view model
                selectedActivities = onboardingViewModel.selectedActivities
            }
            .onChange(of: selectedActivities) { _, newValue in
                // Update view model when local selection changes
                onboardingViewModel.selectedActivities = newValue
            }
            .onChange(of: onboardingViewModel.onboardingComplete) { _, complete in
                if complete {
                    // Navigate to MainTabView
                }
            }
        }
    }
}

// Helper view for category buttons
struct CategoryButton: View {
    let title: String
    let width: CGFloat
    @Binding var selectedActivities: Set<String>
    
    var isSelected: Bool {
        selectedActivities.contains(title)
    }
    
    var body: some View {
        Button(action: {
            if isSelected {
                selectedActivities.remove(title)
            } else {
                selectedActivities.insert(title)
            }
        }) {
            Text(title)
                .bold()
                .font(.system(size: 15))
                .frame(width: width, height: 30)
                .background(isSelected ? Color(red: 4/255, green: 57/255, blue: 11/255) : Color.clear)
                .foregroundColor(isSelected ? Color(red: 255/255, green: 248/255, blue: 228/255) : Color(red: 4/255, green: 57/255, blue: 11/255))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(red: 4/255, green: 57/255, blue: 11/255), lineWidth: 1)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: -2, y: 4)
                )
        }
    }
}

#Preview {
    Onboarding5(onboardingViewModel: OnboardingViewModel(), onComplete: {}, onBack: {})
}
