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

    static func specialDay(for value: String) -> SpecialDays? {
        if SpecialDays.holiday.rawValue == value {
            return .holiday
        } else if SpecialDays.publicHoliday.rawValue == value {
            return .publicHoliday
        } else if SpecialDays.sickness.rawValue == value {
            return .sickness
        } else {
            return nil
        }
    }
}
