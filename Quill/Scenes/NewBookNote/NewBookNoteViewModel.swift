//
//  NewBookNoteViewModel.swift
//  Quill
//
//  Created by Casper Daris on 11/08/2023.
//

import SwiftUI
import Factory

class NewBookNoteViewModel: ObservableObject {
    
    // TODO: REMOVE
    @Injected(\.authManager) private var authManager
    @InjectedObject(\.appCoordinator) private var coordinator
    
    // TODO: We don't want this function
    func handleLogout() async {
        do {
            try await authManager.handleSignOut()
            coordinator.navigateBack()
//            coordinator.closeSheet()
        } catch {
            print("TODO: Error handling \(error)")
        }
    }
}
