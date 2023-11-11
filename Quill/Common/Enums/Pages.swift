//
//  Pages.swift
//  Quill
//
//  Created by Casper Daris on 11/09/2023.
//

import Foundation

/// Representing various pages or screens in the app
/// These are used by the AppCoordinator to handle any navigation
enum Page: String, Identifiable {
    case onboarding
    case signIn
    case signUp
    case home
    case newBook
    case newBookNote
    
    var id: String {
        self.rawValue
    }
}
