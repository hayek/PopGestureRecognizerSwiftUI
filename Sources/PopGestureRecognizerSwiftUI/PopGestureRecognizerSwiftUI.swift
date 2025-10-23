//
//  NavigationPopGestureDisabler.swift
//  SFG
//
//  Created by Amir on 04/11/2024.
//

import SwiftUI
import UIKit

private struct NavigationState {
    weak var currentViewController: UIViewController?
    weak var nextViewController: UIViewController?
    var observationTask: Task<Void, Never>?
}

private enum NavigationStateStore {
    @MainActor
    static var all: [Int: NavigationState] = [:]
}

public extension View {
    /// Disables the iOS interactive pop gesture (swipe back) while this view is on screen.
    @ViewBuilder
    func swipeBackGestureDisabled() -> some View {
        self
            .task {
                guard let navigationController = UIKitNavigationWrapper.getCurrentNavigationController(),
                      let currentVC = navigationController.viewControllers.last else { return }
                
                if NavigationStateStore.all[currentVC.hashValue] == nil {
                    NavigationStateStore.all[currentVC.hashValue] = NavigationState()
                }
                
                NavigationStateStore.all[currentVC.hashValue]?.currentViewController = currentVC
                NavigationStateStore.all[currentVC.hashValue]?.observationTask?.cancel()
                
                if NavigationStateStore.all[currentVC.hashValue]?.nextViewController == nil {
                    // First entry: disable swipe
                    navigationController.interactivePopGestureRecognizer?.isEnabled = false
                    if #available(iOS 26.0, *) {
                        navigationController.interactiveContentPopGestureRecognizer?.isEnabled = false
                    }
                } else {
                    // Wait to detect when this view becomes top again
                    NavigationStateStore.all[currentVC.hashValue]?.observationTask = Task {
                        while !Task.isCancelled {
                            try? await Task.sleep(for: .milliseconds(100))
                            
                            if NavigationStateStore.all[currentVC.hashValue]?.nextViewController == nil {
                                navigationController.interactivePopGestureRecognizer?.isEnabled = false
                                if #available(iOS 26.0, *) {
                                    navigationController.interactiveContentPopGestureRecognizer?.isEnabled = false
                                }
                                break
                            }
                        }
                    }
                }
            }
            .onDisappear {
                guard let navigationController = UIKitNavigationWrapper.getCurrentNavigationController() else { return }

                if let returningVC = navigationController.viewControllers.last {
                    NavigationStateStore.all[returningVC.hashValue]?.observationTask?.cancel()
                }

                if let previousVC = navigationController.viewControllers.secondToLast {
                    NavigationStateStore.all[previousVC.hashValue]?.observationTask?.cancel()

                    if navigationController.viewControllers.contains(where: { $0 == NavigationStateStore.all[previousVC.hashValue]?.currentViewController }) {
                        NavigationStateStore.all[previousVC.hashValue]?.nextViewController = navigationController.viewControllers.last
                    } else {
                        NavigationStateStore.all[previousVC.hashValue] = nil
                    }
                }

                if let lastVC = navigationController.viewControllers.last {
                    let isRecognizerEnabled = !NavigationStateStore.all.keys.contains(lastVC.hashValue)
                    navigationController.interactivePopGestureRecognizer?.isEnabled = false
                    if #available(iOS 26.0, *) {
                        navigationController.interactiveContentPopGestureRecognizer?.isEnabled = isRecognizerEnabled
                    }
                }
            }
    }
}

private extension Array {
    var secondToLast: Element? {
        guard count >= 2 else { return nil }
        return self[count - 2]
    }
}
