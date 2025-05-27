import SwiftUI

struct Onboarding1: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    var onNext: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Header
            Image("traveling")
                .resizable()
                .frame(width: 55, height: 55)
                .offset(x: -38, y: -110)
            
            Text("Step 1")
                .offset(x: 90, y: -100)
                .font(.system(size: 20))
                .bold()
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
            
            Text("Who are you?")
                .offset(x: 0, y: -85)
                .font(.system(size: 40))
                .bold()
                .foregroundColor(Color(red: 4/255, green: 57/255, blue: 11/255))
            
            // Input Field
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .leading) {
                    if onboardingViewModel.name.isEmpty {
                        Text("Your name")
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.45))
                            .offset(x: 18)
                            .allowsHitTesting(false)
                    }
                    
                    TextField("", text: $onboardingViewModel.name)
                        .padding(.horizontal, 15)
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .frame(width: 300, height: 37)
                        .background(Color.clear)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                        .onChange(of: onboardingViewModel.name) { _, _ in
                            // Clear error when user starts typing
                            if onboardingViewModel.nameError != nil {
                                onboardingViewModel.clearNameError()
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(onboardingViewModel.nameError != nil ? .red : .black.opacity(0.45))
                                .shadow(color: .black.opacity(0.8), radius: 2, x: -2, y: 4)
                        )
                }
                
                // Error message
                if let nameError = onboardingViewModel.nameError {
                    Text(nameError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 18)
                }
            }
            .offset(x: -20, y: -65)
            
            // Helper text
            Text("Enter your full name as you'd like others to see it")
                .font(.caption)
                .foregroundColor(.gray)
                .offset(x: -2, y: -50)
            
            Button(action: {
                if onboardingViewModel.validateStep1() {
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
            .offset(x: 180, y: -20)
            
            Image("5dots1")
                .resizable()
                .frame(width: 120, height: 12)
                .offset(x: 65, y: 190)
        }
        .offset(x: 22, y: 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))
        .navigationBarHidden(true)
        .onAppear {
            // Clear any previous errors when the view appears
            onboardingViewModel.clearNameError()
        }
    }
    
    // Simple check that doesn't trigger validation
    private func canProceed() -> Bool {
        return !onboardingViewModel.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

#Preview {
    NavigationStack {
        Onboarding1(onboardingViewModel: OnboardingViewModel(), onNext: {})
    }
}
