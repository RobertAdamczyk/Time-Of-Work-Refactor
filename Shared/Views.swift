//
//  Views.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import Foundation

enum SheetView: Identifiable {
    case addDate
    case editDate(Dates)
    case picker(PickerTypeV2)

    var id: String {
        switch self {
        case .addDate: return "001"
        case .editDate: return "002"
        case .picker: return "003"
        }
    }
}
