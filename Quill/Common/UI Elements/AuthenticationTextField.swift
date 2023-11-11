//
//  AuthenticationTextField.swift
//  Quill
//
//  Created by Casper Daris on 26/08/2023.
//

import SwiftUI

struct AuthenticationTextField: View {
    
    let style: AuthenticationTextFieldStyle
    @Binding var userInput: String
    @Binding var displayingError: Bool
    
    /// If the value for fieldIsSecure is true, the user is not able to see their input
    @State private var fieldIsSecure = true
    /// If the value for shakeAnimation is true, the entire view will animate to indicate that an error is shown
    @State private var shakeAnimation = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(LocalizedStringKey(style.title))
                .font(.manrope(.regular, size: 16))
                .offset(x: 14)
            switch style {
                case .email, .username:
                    TextField(LocalizedStringKey(style.description), text: $userInput)
                        .keyboardType(.emailAddress)
                        .modifier(AuthenticationTextFieldModifier(displayingError: $displayingError))
                case .password, .confirmPassword:
                    HStack {
                        if fieldIsSecure {
                            SecureField(LocalizedStringKey(style.description), text: $userInput)
                        } else {
                            TextField(LocalizedStringKey(style.description), text: $userInput)
                        }
                        EyeIcon(isSecure: $fieldIsSecure) {
                            fieldIsSecure.toggle()
                        }
                    }
                    .modifier(AuthenticationTextFieldModifier(displayingError: $displayingError))
            }
        }
        .offset(x: shakeAnimation ? 10 : 0)
        .onChange(of: displayingError) { animate in
            if animate {
                shakeAnimation = true
                withAnimation(.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                    self.shakeAnimation = false
                }
            }
        }
    }
}

struct AuthenticationTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AuthenticationTextField(style: .email, userInput: .constant("casperdaris@msn.com"), displayingError: .constant(false))
            AuthenticationTextField(style: .password, userInput: .constant("Admin123"), displayingError: .constant(false))
        }
    }
}
