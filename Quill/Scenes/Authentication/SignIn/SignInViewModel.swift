//
//  SignInViewModel.swift
//  Quill
//
//  Created by Casper Daris on 26/08/2023.
//

import SwiftUI
import Factory

class SignInViewModel: ObservableObject {
    
    @Injected(\.authManager) private var authManager
    @InjectedObject(\.appCoordinator) private var coordinator
    
    @Published var userInput = AuthModels.SignInUser(email: "", password: "")
    @Published var currentlyHandling = false
    @Published var continueButtonIsEnabled: Bool = false
    
    // TODO: Is this really the best way with so many inputs? Use enums maybe
    @Published var errorMessage = ""
    @Published var showEmailInputError = false
    @Published var showPasswordInputError = false
    
    // MARK: - Public methods
    
    /// Handle the sign in using email and password
    @MainActor
    func handleUserSignIn() async {
        continueButtonIsEnabled = false
        guard userInputIsValid() else { return }
        currentlyHandling = true
        do {
            try await authManager.handleEmailSignIn(userInput)
            self.currentlyHandling = false
            
            // TODO: What we do here?
//            coordinator.closeSheet()
        } catch {
            displayErrorState(error)
            self.currentlyHandling = false
        }
    }
    
    /// Enable or disable the 'Continue' button
    /// Called whenever one of the TextField inputs in changed
    func updateButtonAndErrorState() {
        errorMessage = ""
        showEmailInputError = false
        showPasswordInputError = false
        continueButtonIsEnabled = !(userInput.email.isEmpty || userInput.password.isEmpty)
    }
    
    /// The state of the SignInView is dependent on the fact if a user is already signed in or not
    func userIsAnonymouslySignedIn() -> Bool {
        ((authManager.getSignedInUser()?.isAnonymous) != nil)
    }
}

private extension SignInViewModel {
    
    /// Check if the email and password inputs are valid
    func userInputIsValid() -> Bool {
        guard userInput.email.isValidEmail else {
            displayErrorState(ValidationError.invalidEmail)
            showEmailInputError = true
            return false
        }
        guard userInput.password.isValidPassword else {
            displayErrorState(ValidationError.invalidPassword)
            showPasswordInputError = true
            return false
        }
        updateButtonAndErrorState()
        return true
    }
    
    func displayErrorState(_ error: Error) {
        switch error {
            case ValidationError.invalidEmail:
                self.errorMessage = ValidationError.invalidEmail.description
                showEmailInputError = true
            case ValidationError.invalidPassword:
                self.errorMessage = ValidationError.invalidPassword.description
                showPasswordInputError = true
            case AuthenticationError.emailSignIn:
                self.errorMessage = AuthenticationError.emailSignIn.description
                showEmailInputError = true
                showPasswordInputError = true
            case AuthenticationError.anonymousSignIn:
                self.errorMessage = AuthenticationError.anonymousSignIn.description
                showEmailInputError = true
                showPasswordInputError = true
            default:
                self.errorMessage = AuthenticationError.genericError.description
                showEmailInputError = true
                showPasswordInputError = true
        }
    }
}

// MARK: - Routing
@MainActor
extension SignInViewModel {
    
    func routeToSignUp() {
        coordinator.routeToPage(.signUp)
        
        // TODO: Need this still?
//        if coordinator.presentedSheet != nil {
//            coordinator.routeToPage(.signUp, presentationStyle: .pushPresentedSheet)
//        } else {
//            coordinator.routeToPage(.signUp)
//        }
    }
}
