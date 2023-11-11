//
//  AuthManager.swift
//  Quill
//
//  Created by Casper Daris on 28/08/2023.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

protocol AuthManagerProtocol {
    
    /// Fetch the data for the logged-in user from AppStorage
    func getSignedInUser() -> UserProfile?
    
    /// Sign-in the user anonymously via Firebase
    /// Anonymous users do not have to provide their email adres or other data to use the application
    /// These users can later sign-up with an email address to keep the access to their data
    func handleAnonymousSignIn() async throws
    
    /// Sign-in the user using their email address
    func handleEmailSignIn(_ model: AuthModels.SignInUser) async throws
    
    /// Register the user in Firebase
    func handleEmailRegister(_ model: AuthModels.RegisterUser) async throws
    
    /// Regioster the user anonymously in Firebase
    func handleAnonymousRegister(_ model: AuthModels.RegisterUser) async throws
    
    /// Sign out the user
    func handleSignOut() async throws
}

// TODO: DOCS
class AuthManager: AuthManagerProtocol {
    

    private let firestore = Firestore.firestore()
    
    @AppStorage(AppStorageKeys.signedInUser.rawValue) private var userData: Data = Data()
    
    // MARK: - Sign In functions
    func handleAnonymousSignIn() async throws {
        do {
            let result = try await Auth.auth().signInAnonymously()
            try await firestore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(result.user.uid)
                .setData([FirebaseKeys.UserDocument.uid.rawValue: result.user.uid,
                          FirebaseKeys.UserDocument.isAnonymous.rawValue: true])
            let user = UserProfile(uid: result.user.uid, isAnonymous: true, name: "To Do: AuthManager")
            userData = try JSONEncoder().encode(user)
        } catch {
            throw AuthenticationError.anonymousSignIn
        }
    }
    
    func handleEmailSignIn(_ model: AuthModels.SignInUser) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: model.email, password: model.password)
            let loggedInUser = try await fetchCurrentUserFromFirestore(id: result.user.uid)
            userData = try JSONEncoder().encode(loggedInUser)
        } catch {
            throw AuthenticationError.emailSignIn
        }
    }
    
    // MARK: - Sign Up functions
    func handleEmailRegister(_ model: AuthModels.RegisterUser) async throws {
        do {
            /// 1. Register the user in FirebaseAuth
            let result = try await Auth.auth().createUser(withEmail: model.email, password: model.password)
            /// 2. Store their data in Firestore
            try await firestore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(result.user.uid)
                .setData([FirebaseKeys.UserDocument.uid.rawValue: result.user.uid,
                          FirebaseKeys.UserDocument.email.rawValue: model.email,
                          FirebaseKeys.UserDocument.username.rawValue: model.username,
                          FirebaseKeys.UserDocument.isAnonymous.rawValue: false])
            /// 3. Create local data object in @AppStorage for the registered user
            let user = UserProfile(uid: result.user.uid, isAnonymous: false, name: model.username)
            userData = try JSONEncoder().encode(user)
        } catch {
            throw AuthenticationError.emailRegister
        }
    }
    
    func handleAnonymousRegister(_ model: AuthModels.RegisterUser) async throws {
        do {
            guard let user = Auth.auth().currentUser else {
                // TODO: Display error dialog
                try await handleSignOut()
                return
            }
            let credential = EmailAuthProvider.credential(withEmail: model.email, password: model.password)
            let result = try await user.link(with: credential)
            try await firestore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(result.user.uid)
                .setData([FirebaseKeys.UserDocument.uid.rawValue: result.user.uid,
                          FirebaseKeys.UserDocument.email.rawValue: model.email,
                          FirebaseKeys.UserDocument.username.rawValue: model.username,
                          FirebaseKeys.UserDocument.isAnonymous.rawValue: false])
            let userProfile = UserProfile(uid: result.user.uid, isAnonymous: false, name: model.username)
            userData = try JSONEncoder().encode(userProfile)
        } catch {
            throw AuthenticationError.anonymousRegister
        }
    }
    
    // MARK: - Miscellaneous
    
    func getSignedInUser() -> UserProfile? {
        guard let profile = try? JSONDecoder().decode(UserProfile.self, from: userData) else { return nil }
        return profile
    }
    
    func handleSignOut() async throws {
        do {
            try Auth.auth().signOut()
            userData = Data()
        } catch {
            throw AuthenticationError.signOut
        }
    }
}

private extension AuthManager {
    
    // TODO: DOCS
    func fetchCurrentUserFromFirestore(id: String) async throws -> UserProfile {
        do {
            let document = try await firestore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(id)
                .getDocument()
            
            // TODO: Waarom eerst decoden, om vervolgens te her-encoden? kan dit niet geskipt worden?
            guard let data = document.data() else { throw AuthenticationError.fetchUserProfileFromFirestore }
            guard let id = data[FirebaseKeys.UserDocument.uid.rawValue] as? String else { throw AuthenticationError.fetchUserProfileFromFirestore }
            guard let username = data[FirebaseKeys.UserDocument.username.rawValue] as? String else { throw AuthenticationError.fetchUserProfileFromFirestore }
            
            return .init(uid: id, isAnonymous: false, name: username)
        } catch {
            throw AuthenticationError.fetchUserProfileFromFirestore
        }
    }
}
