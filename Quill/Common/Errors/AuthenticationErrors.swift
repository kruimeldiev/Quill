//
//  AuthenticationErrors.swift
//  Quill
//
//  Created by Casper Daris on 09/09/2023.
//

import Foundation

enum AuthenticationError: Error {
    
    case genericError
    
    case emailSignIn
    case emailRegister
    
    case anonymousSignIn
    case anonymousRegister
    
    case fetchUserProfileFromFirestore
    case signOut
    
    var description: String {
        switch self {
            case .genericError:
                return NSLocalizedString("authentication_error_generic", comment: "")
            case .emailSignIn:
                return NSLocalizedString("authentication_error_email_signin", comment: "")
            case .emailRegister:
                return NSLocalizedString("authentication_error_email_register", comment: "")
            case .anonymousSignIn:
                return NSLocalizedString("authentication_error_anonymous_signin", comment: "")
            case .anonymousRegister:
                return NSLocalizedString("authentication_error_anonymous_register", comment: "")
            case .fetchUserProfileFromFirestore:
                return NSLocalizedString("authentication_error_fetch_profile", comment: "")
            case .signOut:
                return NSLocalizedString("authentication_error_fetch_profile", comment: "")
        }
    }
}
