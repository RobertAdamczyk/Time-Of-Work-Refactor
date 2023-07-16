//
//  ViewFactory.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import Foundation
import SwiftUI

//struct FullCoverSheetView: View {
//
//    @StateObject var coordinator: Coordinator = .init()
//    @StateObject var appHandler: AppHandler = .init()
//
//    let fullCoverSheet: FullCoverSheet
//    let parentCoordinator: Coordinator
//
//    var body: some View {
//        NavigationStack(path: $coordinator.presentedView) {
//            makeFullCoverSheet(fullCoverSheet)
//                .navigationDestination(for: StackView.self) {
//                    DestinationView(stackView: $0, coordinator: coordinator)
//                }
//        }
//        .toastView(appHandler: appHandler)
//        .fullScreenCover(item: $coordinator.presentedFullCoverSheet) {
//            FullCoverSheetView(fullCoverSheet: $0, parentCoordinator: coordinator)
//        }
//        .sheet(item: $coordinator.presentedStandardSheet) {
//            StandardSheetView(standardSheet: $0, parentCoordinator: coordinator)
//        }
//        .onAppear { coordinator.setup(appHandler: appHandler) }
//    }
//
//    @ViewBuilder
//    private func makeFullCoverSheet(_ fullCoverSheet: FullCoverSheet) -> some View {
//        switch fullCoverSheet {
//        case .addFeed(let context): AddFeedView(coordinator: coordinator,
//                                                parentCoordinator: parentCoordinator,
//                                                context: context)
//        case .register(let shouldShowCloseButton, let onBabyCreated):
//            RegisterView(parentCoordinator: parentCoordinator,
//                         coordinator: coordinator,
//                         onBabyCreated: onBabyCreated,
//                         shouldShowCloseButton: shouldShowCloseButton)
//        case .createAccount: CreateAccountView(coordinator: coordinator, parentCoordinator: parentCoordinator)
//        case .login(let onUserLoggedIn): LoginView(coordinator: coordinator,
//                                                   parentCoordinator: parentCoordinator,
//                                                   onUserLoggedIn: onUserLoggedIn)
//        case .chooseBaby(let shouldShowCloseButton, let babies, let onBabySelected):
//            ChooseBabyView(parentCoordinator: parentCoordinator,
//                           babies: babies,
//                           onBabySelected: onBabySelected,
//                           shouldShowCloseButton: shouldShowCloseButton)
//        }
//    }
//}

struct StandardSheetView: View {

    @StateObject var coordinator: Coordinator = .init()

    let sheetView: SheetView
    let parentCoordinator: Coordinator

    var body: some View {
        makeStandardSheet(sheetView)
            .sheet(item: $coordinator.sheet) {
                StandardSheetView(sheetView: $0, parentCoordinator: coordinator)
            }
    }

    @ViewBuilder
    private func makeStandardSheet(_ sheetView: SheetView) -> some View {
        switch sheetView {
        case .addDate: AddEditDateView(coordinator: coordinator, parentCoordinator: parentCoordinator)
        case .editDate(let workUnit): AddEditDateView(coordinator: coordinator,
                                                      parentCoordinator: parentCoordinator, workUnit: workUnit)
        case .picker(let type): PickerViewV2(type: type, parentCoordinator: parentCoordinator)
                .presentationDetents([.fraction(0.35)])
                .presentationCornerRadius(16)

        }
    }
}

//struct DestinationView: View {
//
//    let stackView: StackView
//    let coordinator: Coordinator
//
//    var body: some View {
//        makeDestination(stackView)
//    }
//
//    @ViewBuilder
//    private func makeDestination(_ view: StackView) -> some View {
//        switch view {
//        case .forgetPassword: ForgetPasswordView(coordinator: coordinator)
//        case .settings: SettingsView(coordinator: coordinator)
//        case .notificationSettings: NotificationSettingsView(coordinator: coordinator)
//        }
//    }
//}
