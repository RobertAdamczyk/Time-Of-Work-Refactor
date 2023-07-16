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
    @Published var showMenu: Bool = false

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    // MARK: Public properties
    /// Record from coreData that AddEditView takes to edit
    var dateToEdit: Dates?

    // MARK: Public functions

    func showMenuAction() {
        Analytics.logFirebaseClickEvent(showMenu ? .hideMenu : .showMenu)
        withAnimation {
            showMenu.toggle()
        }
    }

    func onHistoryRowTapped(date: Dates) {
        coordinator.showSheet(.editDate(date))
    }

    func onToolbarPlusTapped() {
        coordinator.showSheet(.addDate)
    }
}
