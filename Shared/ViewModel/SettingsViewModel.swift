//
//  SettingsViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var hoursWeek = 40
    @Published var daysWeek = 5
}
