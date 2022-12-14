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
        withAnimation {
            showPickerType = pickerType
        }
    }

    func showMenuAction() {
        withAnimation {
            showMenu.toggle()
        }
    }
}
