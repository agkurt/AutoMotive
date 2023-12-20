//
//  AppDelegate.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 3.08.2023.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupInitialViewController()
        restoreGoogleSignIn()
        FirebaseApp.configure()
                
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    // MARK: - Private Helper Functions

    private func setupInitialViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = OnboardingViewController()
        window?.makeKeyAndVisible()
    }
    
    private func restoreGoogleSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                // Handle the error if needed.
                print("Error restoring Google sign-in: \(error.localizedDescription)")
            } else if user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
    }
    
    private func handleGoogleSignInURL(_ url: URL) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    private func handleOtherURL(_ url: URL) -> Bool {
        // Handle other custom URL types here.
        // If not handled by this app, return false.
        return false
    }

    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Handle scene session discarding if necessary.
    }
}

