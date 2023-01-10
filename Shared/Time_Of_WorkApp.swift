//
//  Time_Of_WorkApp.swift
//  Shared
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI
import FirebaseCore
import AppTrackingTransparency

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        requestTrackingAuthorization()
        return true
    }

    private func requestTrackingAuthorization() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    Analytics.activateFirebase()
                case .denied:
                    Analytics.deactivateFirebase()
                default:
                    Analytics.deactivateFirebase()
                }
            }
        }
    }
}

@main
struct TimeOfWorkApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
