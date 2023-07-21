//
//  ViewFactory.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import Foundation
import SwiftUI

struct FullCoverSheetView: View {

    @StateObject var coordinator: Coordinator = .init()

    let fullCoverSheet: FullCoverSheet
    let parentCoordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.stackViews) {
            makeFullCoverSheet(fullCoverSheet)
                .navigationDestination(for: Stack.self) {
                    DestinationView(stack: $0, coordinator: coordinator)
                }
        }
        .fullScreenCover(item: $coordinator.presentedFullCoverSheet) {
            FullCoverSheetView(fullCoverSheet: $0, parentCoordinator: coordinator)
        }
        .sheet(item: $coordinator.presentedSheet) {
            StandardSheetView(sheet: $0, parentCoordinator: coordinator)
        }
    }

    @ViewBuilder
    private func makeFullCoverSheet(_ fullCoverSheet: FullCoverSheet) -> some View {
        switch fullCoverSheet {
        #if DEBUG
        case .debugMenu: DebugMenuView(parentCoordinator: parentCoordinator)
        #endif
        }
    }
}

struct StandardSheetView: View {

    @StateObject var coordinator: Coordinator = .init()

    let sheet: Sheet
    let parentCoordinator: Coordinator

    var body: some View {
        makeStandardSheet(sheet)
            .sheet(item: $coordinator.presentedSheet) {
                StandardSheetView(sheet: $0, parentCoordinator: coordinator)
            }
    }

    @ViewBuilder
    private func makeStandardSheet(_ sheet: Sheet) -> some View {
        switch sheet {
        case .addDate: AddEditDateView(coordinator: coordinator, parentCoordinator: parentCoordinator)
        case .editDate(let workUnit): AddEditDateView(coordinator: coordinator,
                                                      parentCoordinator: parentCoordinator, workUnit: workUnit)
        case .picker(let type): PickerViewV2(type: type, parentCoordinator: parentCoordinator)
                .presentationDetents([.fraction(0.35)])
                .presentationCornerRadius(16)

        }
    }
}

struct DestinationView: View {

    let stack: Stack
    let coordinator: Coordinator

    var body: some View {
        makeDestination(stack)
    }

    @ViewBuilder
    private func makeDestination(_ stack: Stack) -> some View {
        switch stack {
        case .settings(let view):
            switch view {
            case .main: MainSettingView(coordinator: coordinator)
            case .lockScreenSettings(let viewModel): LockScreenView(viewModel: viewModel)
            case .timeSettings(let viewModel): TimeSettingView(viewModel: viewModel)
            }
        }
    }
}
