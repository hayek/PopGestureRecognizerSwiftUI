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
    static var all: [UIViewController: NavigationState] = [:]
}

public extension View {
    /// Disables the iOS interactive pop gesture (swipe back) while this view is on screen.
    @ViewBuilder
    func swipeBackGestureDisabled() -> some View {
        self
            .task {
                guard let navigationController = UIKitNavigationWrapper.getCurrentNavigationController(),
                      let currentVC = navigationController.viewControllers.last else { return }

                if NavigationStateStore.all[currentVC] == nil {
                    NavigationStateStore.all[currentVC] = NavigationState()
                }

                NavigationStateStore.all[currentVC]?.currentViewController = currentVC
                NavigationStateStore.all[currentVC]?.observationTask?.cancel()

                if NavigationStateStore.all[currentVC]?.nextViewController == nil {
                    // First entry: disable swipe
                    navigationController.interactivePopGestureRecognizer?.isEnabled = false
                } else {
                    // Wait to detect when this view becomes top again
                    NavigationStateStore.all[currentVC]?.observationTask = Task {
                        while !Task.isCancelled {
                            try? await Task.sleep(for: .milliseconds(100))

                            if NavigationStateStore.all[currentVC]?.nextViewController == nil {
                                navigationController.interactivePopGestureRecognizer?.isEnabled = false
                                break
                            }
                        }
                    }
                }
            }
            .onDisappear {
                guard let navigationController = UIKitNavigationWrapper.getCurrentNavigationController() else { return }

                if let returningVC = navigationController.viewControllers.last {
                    NavigationStateStore.all[returningVC]?.observationTask?.cancel()
                }

                if let previousVC = navigationController.viewControllers.secondToLast {
                    NavigationStateStore.all[previousVC]?.observationTask?.cancel()

                    if navigationController.viewControllers.contains(where: { $0 == NavigationStateStore.all[previousVC]?.currentViewController }) {
                        NavigationStateStore.all[previousVC]?.nextViewController = navigationController.viewControllers.last
                    } else {
                        NavigationStateStore.all[previousVC] = nil
                    }
                }

                if let lastVC = navigationController.viewControllers.last {
                    navigationController.interactivePopGestureRecognizer?.isEnabled = !NavigationStateStore.all.keys.contains(lastVC)
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
