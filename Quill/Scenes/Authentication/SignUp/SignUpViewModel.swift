//
//  SignUpViewModel.swift
//  Quill
//
//  Created by Casper Daris on 08/09/2023.
//

import SwiftUI
import Factory

class SignUpViewModel: ObservableObject {
    
    @Injected(\.authManager) private var authManager
    @InjectedObject(\.appCoordinator) private var coordinator
    
    @Published var userInput = AuthModels.RegisterUser(email: "",
                                                       password: "",
                                                       passwordVerify: "",
                                                       username: "")
    @Published var currentlyHandling = false
    @Published var signUpButtonIsEnabled: Bool = false
    
    // TODO: Is this really the best way with so many inputs? Use enums maybe
    @Published var errorMessage = ""
    @Published var showEmailInputError = false
    @Published var showUsernameInputError = false
    @Published var showPasswordInputError = false
    @Published var showPasswordVerifyInputError = false
    
    // MARK: - Public methods
    
    /// Handle the sign up using email and password
    @MainActor
    func handleSignUp() async {
        signUpButtonIsEnabled = false
        /// 1. Validate the data
        guard userInputIsValid() else { return }
        /// 2. Check if there is already an (anonymous) user signed in, otherwise we continue with the normal sign up proces
        if let _ = authManager.getSignedInUser() {
            await handleSignUpAnonymousUser()
            return
        }
        /// 3. Start handling
        currentlyHandling = true
        do {
            try await authManager.handleEmailRegister(userInput)
            self.currentlyHandling = false
        } catch {
            displayErrorState(error)
            self.currentlyHandling = false
        }
    }
    
    /// Enable or disable the sign up button, also reset any error state
    /// Called whenever one of the TextField inputs in changed
    func updateButtonAndErrorState() {
        errorMessage = ""
        showEmailInputError = false
        showUsernameInputError = false
        showPasswordInputError = false
        showPasswordVerifyInputError = false
        signUpButtonIsEnabled = !(userInput.email.isEmpty ||
                                  userInput.password.isEmpty ||
                                  userInput.passwordVerify.isEmpty ||
                                  userInput.username.isEmpty)
    }
}

private extension SignUpViewModel {
    
    /// Check if all the inputs are valid before we continue with the sign up proces
    /// Otherwise we will display an error state
    func userInputIsValid() -> Bool {
        guard userInput.email.isValidEmail else {
            displayErrorState(ValidationError.invalidEmail)
            return false
        }
        guard userInput.username.isValidUsername else {
            displayErrorState(ValidationError.invalidUsername)
            return false
        }
        guard userInput.password.isValidPassword else {
            displayErrorState(ValidationError.invalidPassword)
            return false
        }
        guard userInput.password == userInput.passwordVerify else {
            displayErrorState(ValidationError.passwordMismatch)
            return false
        }
        updateButtonAndErrorState()
        return true
    }
    
    /// Handle the sign up when the user is signed in anonymously
    @MainActor
    func handleSignUpAnonymousUser() async {
        currentlyHandling = true
        do {
            try await authManager.handleAnonymousRegister(userInput)
            currentlyHandling = false
            
            // TODO: How we handle here?
//            coordinator.closeSheet()
        } catch {
            displayErrorState(error)
            self.currentlyHandling = false
        }
    }
    
    func displayErrorState(_ error: Error) {
        switch error {
            case ValidationError.invalidEmail:
                self.errorMessage = ValidationError.invalidEmail.description
                showEmailInputError = true
            case ValidationError.invalidUsername:
                self.errorMessage = ValidationError.invalidUsername.description
                showUsernameInputError = true
            case ValidationError.invalidPassword:
                self.errorMessage = ValidationError.invalidPassword.description
                showPasswordInputError = true
            case ValidationError.passwordMismatch:
                self.errorMessage = ValidationError.passwordMismatch.description
                showPasswordVerifyInputError = true
            case AuthenticationError.emailRegister:
                self.errorMessage = AuthenticationError.emailRegister.description
                showEmailInputError = true
                showUsernameInputError = true
                showPasswordInputError = true
                showPasswordVerifyInputError = true
            default:
                self.errorMessage = AuthenticationError.genericError.description
                showEmailInputError = true
                showUsernameInputError = true
                showPasswordInputError = true
                showPasswordVerifyInputError = true
        }
    }
}

// MARK: - Routing
@MainActor
extension SignUpViewModel {
    
    func routeToSignIn() {
        coordinator.navigateBack()
    }
}
