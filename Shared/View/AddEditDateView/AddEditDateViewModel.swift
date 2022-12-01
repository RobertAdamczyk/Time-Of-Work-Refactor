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
        withAnimation {
            showPickerType = pickerType
        }
    }
}
