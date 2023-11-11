//
//  AuthenticationTextFieldStyles.swift
//  Quill
//
//  Created by Casper Daris on 26/08/2023.
//

import SwiftUI

/// Enumeration representing different styles for authentication text fields.
enum AuthenticationTextFieldStyle {
    
    case email
    case password
    case confirmPassword
    case username
    
    var title: String {
        switch self {
            case .email:
                return "sign_in_email"
            case .password:
                return "sign_in_password"
            case .confirmPassword:
                return "sign_up_confirm_password"
            case .username:
                return "sign_in_username"
        }
    }
    
    var description: String {
        switch self {
            case .email:
                return "sign_in_enter_email"
            case .password:
                return "sign_in_enter_password"
            case .confirmPassword:
                return "sign_up_enter_confirm_password"
            case .username:
                return "sign_in_enter_username"
        }
    }
}
