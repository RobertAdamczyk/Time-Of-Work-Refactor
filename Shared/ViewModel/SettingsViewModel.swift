//
//  SettingsViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {

    // MARK: Published variables
    @Published var hoursWeek = UserDefaults.standard.object(forKey: "hoursWeek") as? Int ?? 40
    @Published var daysWeek = UserDefaults.standard.object(forKey: "daysWeek") as? Int ?? 5
}
