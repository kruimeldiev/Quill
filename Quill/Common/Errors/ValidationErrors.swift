//
//  ValidationError.swift
//  Quill
//
//  Created by Casper Daris on 09/09/2023.
//

import Foundation

enum ValidationError: Error {
    
    case invalidEmail
    case invalidPassword
    case invalidUsername
    case passwordMismatch
    
    var description: String {
        switch self {
            case .invalidEmail:
                return NSLocalizedString("validation_error_email", comment: "")
            case .invalidPassword:
                return NSLocalizedString("validation_error_password", comment: "")
            case .invalidUsername:
                return NSLocalizedString("validation_error_username", comment: "")
            case .passwordMismatch:
                return NSLocalizedString("validation_error_password_mismatch", comment: "")
        }
    }
}
