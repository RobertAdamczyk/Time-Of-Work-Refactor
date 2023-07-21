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

        let liveActivitiesService: LiveActivitiesService = .init()
        let coreDataService: CoreDataService = .init()

        let dependencies: Dependencies = .init(coreDataService: coreDataService,
                                               liveActivitiesService: liveActivitiesService)

        DependencyContainer.register(dependencies as Dependencies)

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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var coordinator: Coordinator

    init() {
        self._coordinator = .init(wrappedValue: .init())
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.stackViews) {
                MainView(coordinator: coordinator)
                    .blur(radius: coordinator.shouldShowMenu ? 10 : 0)
                    .animation(.easeInOut, value: coordinator.shouldShowMenu)
                    .navigationDestination(for: Stack.self) {
                        DestinationView(stack: $0, coordinator: coordinator)
                    }
            }
            .sheet(item: $coordinator.presentedSheet) {
                StandardSheetView(sheet: $0, parentCoordinator: coordinator)
            }
            .fullScreenCover(item: $coordinator.presentedFullCoverSheet) {
                FullCoverSheetView(fullCoverSheet: $0, parentCoordinator: coordinator)
            }
            .overlay {
                MenuView(coordinator: coordinator)
                    .offset(x: coordinator.shouldShowMenu ? 0 : -Config.screenWidth)
                    .animation(.easeInOut, value: coordinator.shouldShowMenu)
            }
            .tint(Color.theme.accent)
            #if DEBUG
            .onShake {
                coordinator.onDeviceShaked()
            }
            #endif
        }
    }
}
