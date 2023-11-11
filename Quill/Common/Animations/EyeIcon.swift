//
//  EyeIcon.swift
//  Quill
//
//  Created by Casper Daris on 26/08/2023.
//

import SwiftUI

struct EyeIcon: View {
    
    @Binding var isSecure: Bool
    var iconTapped: () -> ()
    
    var body: some View {
        ZStack {
            Image("ic_eye")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.textBody)
            Rectangle()
                .foregroundColor(.textBody)
                .frame(width: 2, height: isSecure ? 0 : 26)
                .rotationEffect(.degrees(45))
                .animation(.interpolatingSpring(stiffness: 600, damping: 30), value: isSecure)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            iconTapped()
        }
    }
}

struct EyeIcon_Previews: PreviewProvider {
    static var previews: some View {
        EyeIcon(isSecure: .constant(false)) { }
    }
}
