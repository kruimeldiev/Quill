//
//  ScaleUpBackButton.swift
//  Quill
//
//  Created by Casper Daris on 08/09/2023.
//

import SwiftUI
import Factory

/// Customized back button that can be used as ToolBarItem
struct ScaleUpBackButton: View {
    
    @InjectedObject(\.appCoordinator) private var coordinator
    
    @State private var isToolbarItemVisible = false
    var withScaleEffect: Bool
    var iconName: String
    
    init(withScaleEffect: Bool = true,
         iconName: String = "arrow.left") {
        self.withScaleEffect = withScaleEffect
        self.iconName = iconName
    }
    
    var body: some View {
        Button {
            Task { coordinator.navigateBack() }
        } label: {
            Text("")
                .modifier(IconButton(width: 40,
                                     height: 40,
                                     backgroundColor: .primaryAccentBrown,
                                     iconName: iconName))
        }
        .opacity(isToolbarItemVisible ? 1 : 0)
        .scaleEffect(withScaleEffect ? (isToolbarItemVisible ? 1 : 0.7) : 1, anchor: .center)
        .onAppear {
            withAnimation {
                isToolbarItemVisible = true
            }
        }
    }
}

struct ScaleUpBackButton_Previews: PreviewProvider {
    static var previews: some View {
        ScaleUpBackButton()
    }
}
