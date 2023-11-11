//
//  FirebaseKeys.swift
//  Quill
//
//  Created by Casper Daris on 05/09/2023.
//

import Foundation

enum FirebaseKeys: Equatable {
    
    /// The names of all the collections we've got in Firestore
    enum Collections: String {
        case users
    }
    
    /// The data for signed up user properties as stored in Firestore
    enum UserDocument: String {
        case uid
        case email
        case username
        case isAnonymous
    }
}
