//
//  Coordinator.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import SwiftUI

final class Coordinator: ObservableObject {

    @Published var sheet: SheetView?

    func showSheet(_ sheet: SheetView) {
        self.sheet = sheet
    }

    func dismissSheet() {
        self.sheet = nil
    }
}
