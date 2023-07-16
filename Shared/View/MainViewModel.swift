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
    @Published var showPickerType: PickerType?
    @Published var showMenu: Bool = false

    var isSheetActive: Bool {
        coordinator.sheet != nil
    }

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    // MARK: Public properties
    /// Record from coreData that AddEditView takes to edit
    var dateToEdit: Dates?

    // MARK: Public functions
    func showPicker(pickerType: PickerType?) {
        logPicker(for: pickerType)
        withAnimation {
            showPickerType = pickerType
        }
    }

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

// MARK: Analytics
extension MainViewModel {
    private func logPicker(for pickerType: PickerType?) {
        let analyticsValue: Analytics.Value
        switch pickerType {
        case .pause:
            analyticsValue = .pausePicker
        case .timeIn:
            analyticsValue = .timeInPicker
        case .timeOut:
            analyticsValue = .timeOutPicker
        case .date:
            analyticsValue = .datePicker
        default:
            analyticsValue = .closePicker
        }
        Analytics.logFirebaseClickEvent(analyticsValue)
    }
}
