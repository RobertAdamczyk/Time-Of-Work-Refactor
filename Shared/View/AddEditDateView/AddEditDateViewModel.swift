//
//  AddDateViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import Foundation
import SwiftUI
import CoreData

class AddEditDateViewModel: ObservableObject {

    // MARK: Published variables
    @Published var new = New()
    @Published var showPickerType: PickerType?

    // MARK: Public functions
    func showPicker(pickerType: PickerType?) {
        logPicker(for: pickerType)
        withAnimation {
            showPickerType = pickerType
        }
    }
}

// MARK: Analytics
extension AddEditDateViewModel {
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
