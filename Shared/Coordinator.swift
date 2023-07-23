//
//  Coordinator.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import SwiftUI

final class Coordinator: ObservableObject {

    @Published var stackViews: [Stack] = []
    @Published var presentedSheet: Sheet?
    @Published var presentedFullCoverSheet: FullCoverSheet?

    @Published private(set) var shouldShowMenu = false

    func push(_ stack: Stack) {
        stackViews.append(stack)
    }

    func pop() {
        stackViews.removeLast()
    }

    func showSheet(_ sheet: Sheet) {
        self.presentedSheet = sheet
    }

    func showFullCoverSheet(_ fullCoverSheet: FullCoverSheet) {
        self.presentedFullCoverSheet = fullCoverSheet
    }

    func dismissSheet() {
        self.presentedSheet = nil
        self.presentedFullCoverSheet = nil
    }

    func showMenu() {
        Analytics.logFirebaseClickEvent(.showMenu)
        shouldShowMenu = true
    }

    func hideMenu() {
        Analytics.logFirebaseClickEvent(.hideMenu)
        shouldShowMenu = false
    }
}

#if DEBUG
extension Coordinator {
    func onDeviceShaked() {
        showFullCoverSheet(.debugMenu)
    }
}
#endif
