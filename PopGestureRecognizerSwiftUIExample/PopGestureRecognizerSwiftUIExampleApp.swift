//
//  PopGestureRecognizerSwiftUIExampleApp.swift
//  PopGestureRecognizerSwiftUIExample
//
//  Created by amir on 16/05/2025.
//

import SwiftUI

@main
struct PopGestureRecognizerSwiftUIExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            FirstView()
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Custom app initialization code can go here
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

extension View {
    func modifyOrientation(to orientation: UIInterfaceOrientationMask)  {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            AppDelegate.orientationLock = orientation
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientation))
            windowScene.keyWindow?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }
}
