//
//  HomeViewModel.swift
//  Quill
//
//  Created by Casper Daris on 13/07/2023.
//

import SwiftUI
import Factory

class HomeViewModel: ObservableObject {
    
    @Injected(\.authManager) private var authManager
    @InjectedObject(\.appCoordinator) private var coordinator
    
    @Published var books = [Book]()
    @Published var selectedBookIndex = 2
    
    @Published var greetingsMessage: String = ""
    @Published var username: String = ""
    
    init() {
        self.books = [Book.stubShort,
                      Book.stubMedium,
                      Book.stubMedium,
                      Book.stubLong,
                      Book.stubShort,
                      Book.stubLong]
    }
    
    @MainActor
    func signOutUser() async {
        do {
            try await authManager.handleSignOut()
        } catch {
            // TODO: Handle errors
            print(error)
        }
    }
    
    func getMenuOptions() -> [MenuItem] {
        guard let user = authManager.getSignedInUser() else {
            // TODO: Error handling
            print("WTF")
            return []
        }
        let userSpecificOptions: MenuItem = user.isAnonymous ? .signIn : .signOut
        return [.addNewBook,
                .separator,
                .sortBooks,
                .filterBooks,
                .separator,
                .sortNotes,
                .filterNotes,
                .separator,
                userSpecificOptions]
    }
    
    func setGreetingsMessage() {
        // TODO: This is an issue. In the authManager.handleEmailSignIn function the user is signed in before the loggedInUser is loaded from Firestore. Because of that, the HomeView is displayed with "Anonymous" name instead of the real name. Fix that.
        self.username = authManager.getSignedInUser()?.name ?? "Anonymous"
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        switch hour {
            case 4..<12:
                greetingsMessage = "greeting_morning"
            case 12..<18:
                greetingsMessage = "greeting_afternoon"
            default:
                greetingsMessage = "greeting_evening"
        }
    }
}

// MARK: - Routing
@MainActor
extension HomeViewModel {
    
    // TODO: Should be sheet?
    func routeToSignIn() {
        coordinator.routeToPage(.signIn)
    }
    
    // TODO: Should be sheet?
    func routeToNewBook() {
        coordinator.routeToPage(.newBook)
    }
    
    // TODO: Should be sheet?
    func routeToNewBookNote() {
        coordinator.routeToPage(.newBookNote)
    }
}
