import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    var isSecure: Bool = false
    var isEmail: Bool = false
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(icon)
                    .foregroundColor(.gray)
                
                ZStack(alignment: .leading) {
                    // Floating placeholder
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.black.opacity(0.45))
                            .font(.system(size: 18))
                            .allowsHitTesting(false)
                    }
                    
                    if isSecure && !isPasswordVisible {
                        SecureField("", text: $text)
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    } else {
                        TextField("", text: $text)
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                            .textInputAutocapitalization(isEmail ? .never : .words)
                            .keyboardType(isEmail ? .emailAddress : .default)
                            .autocorrectionDisabled(isEmail)
                    }
                }
                
                if isSecure {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.bottom, 4)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.5))
                    .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 5),
                alignment: .bottom
            )
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        CustomTextField(
            placeholder: "Email",
            text: .constant(""),
            icon: "user",
            isEmail: true
        )
        
        CustomTextField(
            placeholder: "Password",
            text: .constant(""),
            icon: "lock",
            isSecure: true
        )
    }
    .padding()
    .background(Color(red: 255/255, green: 248/255, blue: 228/255))
} 