//
//  SpecialDaysEnum.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 28.03.21.
//

import Foundation

enum SpecialDays: String, CaseIterable, Identifiable {
    case holiday = "Holiday"
    case publicHoliday = "Public Holiday"
    case sickness = "Sickness"
    
    var id: Int {
        hashValue
    }
}
