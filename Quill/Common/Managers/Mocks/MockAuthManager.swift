//
//  MockAuthManager.swift
//  Quill
//
//  Created by Casper Daris on 09/09/2023.
//

import Foundation

class MockAuthManager: AuthManagerProtocol {
    
    // TODO: This 
    var userIsLoggedIn: Bool = false
    
    func getSignedInUser() -> UserProfile? {
        return nil
    }
    
    func handleAnonymousSignIn() async throws {
        print("To do: Mock")
    }
    
    func handleEmailSignIn(_ model: AuthModels.SignInUser) async throws {
        // TODO:
    }
    
    func handleEmailRegister(_  bmodel: AuthModels.RegisterUser) async throws {
        // TODO:
    }
    
    func handleAnonymousRegister(_ model: AuthModels.RegisterUser) async throws {
        // TODO:
    }
    
    func handleSignOut() async throws {
        print("To do: Mock")
    }
}
