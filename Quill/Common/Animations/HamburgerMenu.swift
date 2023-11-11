//
//  HamburgerMenu.swift
//  Quill
//
//  Created by Casper Daris on 26/08/2023.
//

import SwiftUI

struct HamburgerMenuButton: View {
    
    var size: CGFloat
    var color: Color = .textTitle
    @Binding var menuIsOpen: Bool
    
    var body: some View {
        VStack(alignment: .trailing, spacing: menuIsOpen ? (size / 1.67) : (size / 4)) {
            Rectangle()
                .foregroundColor(color)
                .frame(width: size, height: (size / 8))
                .rotationEffect(.degrees(menuIsOpen ? -45 : 0), anchor: .trailing)
            Rectangle()
                .foregroundColor(color)
                .frame(width: menuIsOpen ? size : (size / 1.5), height: (size / 8))
                .rotationEffect(.degrees(menuIsOpen ? 45 : 0), anchor: .trailing)
        }
        .animation(.interpolatingSpring(stiffness: 300, damping: 15), value: menuIsOpen)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.3,
                                             dampingFraction: 0.7,
                                             blendDuration: 0.7)) {
                menuIsOpen.toggle()
            }
        }
    }
}

struct HamburgerMenu_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerMenuButton(size: 24, menuIsOpen: .constant(false))
    }
}
