import SwiftUI

struct OnboardingFlow: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @EnvironmentObject var appStateManager: AppStateManager
    @State private var currentStep = 1
    
    var body: some View {
        NavigationStack {
            Group {
                switch currentStep {
                case 1:
                    Onboarding1(
                        onboardingViewModel: onboardingViewModel,
                        onNext: { currentStep = 2 }
                    )
                case 2:
                    Onboarding2(
                        onboardingViewModel: onboardingViewModel,
                        onNext: { currentStep = 3 },
                        onBack: { currentStep = 1 }
                    )
                case 3:
                    Onboarding3(
                        onboardingViewModel: onboardingViewModel,
                        onNext: { currentStep = 4 },
                        onBack: { currentStep = 2 }
                    )
                case 4:
                    Onboarding4(
                        onboardingViewModel: onboardingViewModel,
                        onNext: { currentStep = 5 },
                        onBack: { currentStep = 3 }
                    )
                case 5:
                    Onboarding5(
                        onboardingViewModel: onboardingViewModel,
                        onComplete: { 
                            // The view model will set onboardingComplete to true
                            // which will be handled by the onChange below
                        },
                        onBack: { currentStep = 4 }
                    )
                default:
                    MainTabView()
                }
            }
        }
        .onChange(of: onboardingViewModel.onboardingComplete) { _, complete in
            if complete {
                // Update app state manager
                appStateManager.completeOnboarding()
            }
        }
    }
} 