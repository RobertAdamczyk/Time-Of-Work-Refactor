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
            return ImageStore.caseFill.image
        case .publicHoliday:
            return ImageStore.flag.image
        case .sickness:
            return ImageStore.bandage.image
        }
    }

    var string: String {
        switch self {
        case .holiday: return localized(string: "add_edit_vacation")
        case .publicHoliday: return localized(string: "add_edit_public_holiday")
        case .sickness: return localized(string: "add_edit_sickness")
        }
    }

    var analyticsValue: String {
        switch self {
        case .holiday: return "holiday"
        case .publicHoliday: return "public_holiday"
        case .sickness: return "sickness"
        }
    }
}
