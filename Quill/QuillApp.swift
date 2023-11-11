//
//  QuillApp.swift
//  Quill
//
//  Created by Casper Daris on 13/07/2023.
//

import SwiftUI
import Firebase
import Factory

@main
struct QuillApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @InjectedObject(\.appCoordinator) private var coordinator
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.background.ignoresSafeArea()
                
                // TODO: Misschien de NavigationStack in de coordinator plaatsen zodat ik geen @Published hoef te gebruiken?
                NavigationStack(path: $coordinator.path) {
                    coordinator.getView(coordinator.userIsLoggedIn ? .home : .onboarding)
                        .navigationDestination(for: Page.self) { page in
                            coordinator.getView(page)
                                .navigationBarBackButtonHidden(true)
                        }
                        .navigationBarBackButtonHidden(true)
                }
            }
            // TODO: Add sheet overlay?path.append(page)
//            .sheet(item: $coordinator.presentedSheet) { page in
//                NavigationStack(path: $coordinator.presentedSheetPath) {
//                    coordinator.getView(page)
//                        .navigationDestination(for: Page.self) { page in
//                            coordinator.getView(page)
//                        }
//                }
//            }
        }
    }
}

/// The AppDelegate can handle different cases for when the app has launched, opend from background, goes to background, etc.
/// We also use it to initialize Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
