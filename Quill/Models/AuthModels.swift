//
//  AuthModels.swift
//  Quill
//
//  Created by Casper Daris on 05/09/2023.
//

import Foundation

/// These models are used for authentication
/// We use these models iside the ViewModels for increased testability
enum AuthModels {
    
    struct SignInUser {
        var email: String
        var password: String
    }
    
    struct RegisterUser {
        var email: String
        var password: String
        var passwordVerify: String
        var username: String
    }
}
