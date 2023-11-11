//
//  OnboardingViewModel.swift
//  Quill
//
//  Created by Casper Daris on 11/08/2023.
//

import SwiftUI
import Factory

class OnboardingViewModel: ObservableObject {
    
    @Injected(\.authManager) private var authManager
    @InjectedObject(\.appCoordinator) private var coordinator
    
    func handleAnonymousSignIn() async {
        
        // TODO: Loading indicator
        
        do {
            try await authManager.handleAnonymousSignIn()
        } catch {
            // TODO: Error handling
            print("TODO: Error handling \(error)")
        }
    }
}

// MARK: - Routing
@MainActor
extension OnboardingViewModel {
    
    func routeToSignIn() {
        coordinator.routeToPage(.signIn)
    }
}
