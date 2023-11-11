//
//  ButtonModifiers.swift
//  Quill
//
//  Created by Casper Daris on 25/08/2023.
//

import SwiftUI

struct AppPrimaryButton: ViewModifier {

    let backgroundColor: Color
    let disabledColor: Color
    let foregroundColor: Color
    let withBorder: Bool
    @Binding var buttonIsEnabled: Bool

    init(buttonIsEnabled: Binding<Bool> = .constant(true),
         backgroundColor: Color = .primaryAccentBrown,
         disabledColor: Color = .secondaryAccentBrown,
         foregroundColor: Color = .white,
         withBorder: Bool = false) {
        self._buttonIsEnabled = buttonIsEnabled
        self.backgroundColor = backgroundColor
        self.disabledColor = disabledColor
        self.foregroundColor = foregroundColor
        self.withBorder = withBorder
    }
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 48)
            .font(.manrope(.regular, size: 16))
            .foregroundColor(buttonIsEnabled ? foregroundColor : .textBody)
            .background(buttonIsEnabled ? backgroundColor : disabledColor)
            .cornerRadius(.infinity)
            .overlay {
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(Color.textAccent, lineWidth: withBorder ? 1 : 0)
            }
    }
}

struct IconButton: ViewModifier {
    
    let width: CGFloat
    let height: CGFloat
    let backgroundColor: Color
    let iconName: String

    func body(content: Content) -> some View {
        ZStack {
            content
                .font(.headline)
                .frame(width: width, height: height)
                .background(backgroundColor)
                .cornerRadius(width)
            Image(systemName: iconName)
                .foregroundColor(.white)
        }
    }
}
