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
    @Published var new = New()
    @Published var showComponent: ShowComponents?

    func changeShowComponent(newValue: ShowComponents?) {
        withAnimation {
            // if old value is new value remove picker from screen
            showComponent = showComponent == newValue ? nil : newValue
        }
    }
}
