//
//  MainViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//
import SwiftUI

class MainViewModel: ObservableObject {

    // MARK: Published variables
    @Published var view = Views.home

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    // MARK: Public properties
    /// Record from coreData that AddEditView takes to edit
    var dateToEdit: Dates?

    // MARK: Public functions

    func onToolbarPlusTapped() {
        coordinator.showSheet(.addDate)
    }

    func onMenuTapped() {
        coordinator.showMenu()
    }
}
