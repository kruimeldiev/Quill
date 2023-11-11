//
//  Container + Extensions.swift
//  Quill
//
//  Created by Casper Daris on 11/08/2023.
//

import Factory

/// This container handles all the Dependency Injection using the Factory SDK
extension Container {
    
    /// Possible scopes
    /// 1. Cached: The same instance will be returned by the factory until the cache is reset.
    /// 2. Graph: A single instance of a given type will be returned during a given resolution cycle.
    /// 3. Shared: The same instance will be returned by the factory as long as someone maintains a strong reference.
    /// 4. Singleton: The same instance will always be returned by the factory.
    /// 5. Unique: A new instance of a given type will be returned on every resolution cycle.
    
    /// Setup all protocols to their tetsing doubles
    func setupMocks() {
        authManager.register { MockAuthManager() }
    }
    
    // MARK: - Managers
    var authManager: Factory<AuthManagerProtocol> {
        self { AuthManager() }.singleton
    }
    
    // TODO: Huh?
    @MainActor
    var appCoordinator: Factory<AppCoordinator> {
        self { AppCoordinator() }.singleton
    }
}
