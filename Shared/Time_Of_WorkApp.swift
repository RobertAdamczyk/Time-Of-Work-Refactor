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
        #if DEBUG
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-Debug", ofType: "plist")
        #else
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        #endif

        if let filePath = filePath, let options = FirebaseOptions(contentsOfFile: filePath) {
            FirebaseApp.configure(options: options)
            requestTrackingAuthorization()
        }
        return true
    }

    private func requestTrackingAuthorization() {
        // I don't know why, but i need make 2 sec delay to show request
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
    @StateObject var coordinator: Coordinator = .init()
    @StateObject var coreDataManager = CoreDataManager()
    var body: some Scene {
        WindowGroup {
            MainView(coordinator: coordinator)
                .sheet(item: $coordinator.sheet) {
                    StandardSheetView(sheetView: $0, parentCoordinator: coordinator)
                }
                .environmentObject(coreDataManager)
        }
    }
}
