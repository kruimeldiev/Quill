//
//  TextFieldViewModifiers.swift
//  Quill
//
//  Created by Casper Daris on 26/08/2023.
//

import SwiftUI

struct AuthenticationTextFieldModifier: ViewModifier {
    
    @Binding var displayingError: Bool
    
    init(displayingError: Binding<Bool> = .constant(false)) {
        self._displayingError = displayingError
    }
    
    func body(content: Content) -> some View {
        content
            .font(.manrope(.light, size: 14))
            .padding()
            .frame(height: 40)
            .background(Color.background)
            .tint(Color.textAccent)
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(displayingError ? Color.textError : Color.textAccent, lineWidth: 1)
            }
    }
}
