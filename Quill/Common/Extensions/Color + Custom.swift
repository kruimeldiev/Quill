//
//  Color + Custom.swift
//  Quill
//
//  Created by Casper Daris on 26/08/2023.
//

import SwiftUI

extension Color {
    
    public static var background: Color {
        return Color(ColorKeys.background.rawValue)
    }
    
    public static var primaryAccentBrown: Color {
        return Color(ColorKeys.primaryAccentBrown.rawValue)
    }
    
    public static var secondaryAccentBrown: Color {
        return Color(ColorKeys.secondaryAccentBrown.rawValue)
    }
    
    public static var textTitle: Color {
        return Color(ColorKeys.textTitle.rawValue)
    }
    
    public static var textAccent: Color {
        return Color(ColorKeys.textAccent.rawValue)
    }
    
    public static var textBody: Color {
        return Color(ColorKeys.textBody.rawValue)
    }
    
    public static var textError: Color {
        return Color(ColorKeys.textError.rawValue)
    }
}
