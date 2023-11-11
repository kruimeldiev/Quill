//
//  UINavigationController + Gesture.swift
//  Quill
//
//  Created by Casper Daris on 27/08/2023.
//

import UIKit

// TODO: This has to work, but crashes the app
/// Extension for the swipe back gesture without using the default back button
extension UINavigationController: UIGestureRecognizerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
