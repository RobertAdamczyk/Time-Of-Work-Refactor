//
//  SpecialDaysEnum.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 28.03.21.
//

import SwiftUI

enum SpecialDays: String, CaseIterable, Identifiable {
    case holiday = "Vacation"
    case publicHoliday = "Public Holiday"
    case sickness = "Sickness"

    var id: String {
        rawValue
    }

    var image: Image {
        switch self {
        case .holiday:
            return Image.store.caseFill
        case .publicHoliday:
            return Image.store.flag
        case .sickness:
            return Image.store.bandage
        }
    }

    var string: String {
        switch self {
        case .holiday: return localized(string: "add_edit_vacation")
        case .publicHoliday: return localized(string: "add_edit_public_holiday")
        case .sickness: return localized(string: "add_edit_sickness")
        }
    }
}
