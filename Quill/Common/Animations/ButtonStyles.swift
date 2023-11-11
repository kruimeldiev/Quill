//
//  ButtonStyles.swift
//  Quill
//
//  Created by Casper Daris on 26/07/2023.
//

import SwiftUI

struct ScaleDownButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: configuration.isPressed ? 0.1 : 0.3),
                       value: configuration.isPressed)
    }
}
