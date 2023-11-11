//
//  Font + Custom.swift
//  Quill
//
//  Created by Casper Daris on 13/07/2023.
//

import SwiftUI

extension Font {
    
    enum Manrope {
        case extraLight
        case light
        case medium
        case regular
        case bold
        case semiBold
        case extraBold
        
        var value: String {
            switch self {
                case .extraLight:
                    return "Manrope-ExtraLight"
                case .light:
                    return "Manrope-Light"
                case .medium:
                    return "Manrope-Medium"
                case .regular:
                    return "Manrope-Regular"
                case .bold:
                    return "Manrope-Bold"
                case .semiBold:
                    return "Manrope-SemiBold"
                case .extraBold:
                    return "Manrope-ExtraBold"
            }
        }
    }
    
    static func manrope(_ type: Manrope, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
