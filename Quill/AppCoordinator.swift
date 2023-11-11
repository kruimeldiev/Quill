//
//  AppCoordinator.swift
//  Quill
//
//  Created by Casper Daris on 11/09/2023.
//

import SwiftUI
import Firebase

/// Coordinator class responsible for managing app navigation
/// The coordinator also listens to any Auth updates from FirebaseAuth and handles accordingly
@MainActor
class AppCoordinator: ObservableObject {
    
    /// A navigation path to keep track of the user's navigation history
    @Published var path = NavigationPath()
    
    /// A boolean flag indicating whether the user is currently logged in via FirebaseAuth
    @Published var userIsLoggedIn: Bool = false
    
    /// A Firebase authentication state change listener
    @State private var authHandler: AuthStateDidChangeListenerHandle? = nil
    
    init() {
        authHandler = Auth.auth().addStateDidChangeListener { _, user in
            self.userIsLoggedIn = (user != nil)
        }
    }
    
    deinit {
        Task {
            if let authHandler = await authHandler {
                Auth.auth().removeStateDidChangeListener(authHandler)
            }
        }
    }
    
    // MARK: - Methods
    
    // TODO: Need to add PresentationStyle?
    /// Navigates to a specified page with an optional presentation style.
    ///
    /// - Parameters:
    ///   - page: The target page to navigate to.
    ///   - presentationStyle: The presentation style for transitioning to the page (default is push).
    func routeToPage(_ page: Page) {
        path.append(page)
    }
    
    /// Returns a SwiftUI view associated with a given page.
    ///
    /// - Parameter page: The target page.
    /// - Returns: A SwiftUI view corresponding to the specified page.
    @ViewBuilder
    func getView(_ page: Page) -> some View {
        switch page {
            case .home:
                HomeView()
            case .onboarding:
                OnboardingView()
            case .signIn:
                SignInView()
            case .signUp:
                SignUpView()
            case .newBook:
                NewBookView()
            case .newBookNote:
                NewBookNoteView()
        }
    }
    
    func navigateBack() {
        if path.count > 1 {
            path.removeLast()
        } else {
            path.removeLast(path.count)
        }
    }
}
