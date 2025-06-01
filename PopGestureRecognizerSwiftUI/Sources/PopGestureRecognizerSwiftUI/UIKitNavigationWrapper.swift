//
//  UIKitNavigationWrapper.swift
//
//
//  Created by amir on 04/11/2024.
//
import Foundation
import SwiftUI
import UIKit

/// Utility functions for finding and retrieving the current navigation controller.
@MainActor
struct UIKitNavigationWrapper {
    /// Recursively searches for a navigation controller in the view controller hierarchy.
    ///
    /// - Parameter viewController: The view controller to start the search from.
    /// - Returns: The found `UINavigationController` or `nil` if not found.
    private static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        
        // If the view controller is a UISplitViewController, check its viewControllers
        if let splitViewController = viewController as? UISplitViewController {
            for vc in splitViewController.viewControllers {
                if let navigationController = findNavigationController(viewController: vc) {
                    return navigationController
                }
            }
        }
        
        // Check if the view controller is a UITabBarController
        if let tabBarController = viewController as? UITabBarController {
            if let tabBarViewController = tabBarController.selectedViewController {
                if let navigationController = findNavigationController(viewController: tabBarViewController) {
                    return navigationController
                }
            }
        }

        // Check if there's a presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            if let navigationController = findNavigationController(viewController: presentedViewController) {
                return navigationController
            }
        }
        
        // Check the children of the current view controller
        for childViewController in viewController?.children ?? [] {
            if let navigationController = findNavigationController(viewController: childViewController) {
                return navigationController
            }
        }
        
        // Check if the view controller itself is a UINavigationController
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        if let navigationController = viewController?.navigationController {
            return navigationController
        }
        
        // If no UINavigationController was found
        return nil
    }

    
    /// Retrieves the current navigation controller for the app.
    ///
    /// - Returns: The current `UINavigationController` or `nil` if not found.
    static func getCurrentNavigationController() -> UINavigationController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        
        return findNavigationController(viewController: keyWindow?.rootViewController)
    }
}

