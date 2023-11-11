//
//  TextModifiers.swift
//  Quill
//
//  Created by Casper Daris on 13/07/2023.
//

import SwiftUI

struct TextAppTitle: ViewModifier {
    let style: Font.Manrope
    let size: Int
    let color: Color
    
    init(style: Font.Manrope = .medium, size: Int = 40, color: Color = .textTitle) {
        self.style = style
        self.size = size
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(.manrope(style, size: CGFloat(size)))
    }
}

struct TextNoteTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.textTitle)
            .font(.manrope(.regular, size: 20))
    }
}

struct TextNoteBody: ViewModifier {
    
    let color: Color
    
    init(color: Color = .textBody) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(.manrope(.medium, size: 14))
    }
}

struct TextAccentButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.primaryAccentBrown)
            .font(.manrope(.medium, size: 14))
    }
}

struct TextCaption: ViewModifier {
    
    let color: Color
    
    init(color: Color = .textAccent) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(.manrope(.medium, size: 12))
    }
}
