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
    @Published var activeSheet: SheetView?
    @Published var showPickerType: PickerType?
    @Published var showMenu: Bool = false

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
