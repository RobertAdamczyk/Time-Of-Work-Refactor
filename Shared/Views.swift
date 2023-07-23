//
//  Views.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import Foundation

enum Sheet: Identifiable {
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

enum FullCoverSheet: Identifiable {
    #if DEBUG
    case debugMenu
    #endif

    var id: String {
        switch self {
        #if DEBUG
        case .debugMenu: return "000"
        #endif

        }
    }
}

enum Stack: Hashable {

    case settings(Settings)

    enum Settings: Hashable {

        case main
        case timeSettings(SettingsViewModel)
        case lockScreenSettings(SettingsViewModel)

        public func hash(into hasher: inout Hasher) {
            return hasher.combine(hashValue)
        }

        static func == (lhs: Stack.Settings, rhs: Stack.Settings) -> Bool {
            switch (lhs, rhs) {
            case (.main, .main): return true
            case (.timeSettings, .timeSettings): return true
            case (.lockScreenSettings, .lockScreenSettings): return true
            default: return false
            }
        }
    }
}
