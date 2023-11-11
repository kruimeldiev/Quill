//
//  UserProfile.swift
//  Quill
//
//  Created by Casper Daris on 28/08/2023.
//

import Foundation

/// This is the model for the logged in user data
/// The data is stored in @AppStorage and can only be set and get from the AuthManager
struct UserProfile: Codable {
    let uid: String
    let isAnonymous: Bool
    let name: String?
}
