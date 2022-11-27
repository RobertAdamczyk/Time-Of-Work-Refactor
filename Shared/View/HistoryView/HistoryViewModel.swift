//
//  HistoryViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 26.11.22.
//

import SwiftUI

class HistoryViewModel: ObservableObject {

    // MARK: Published properties
    @Published var sectionType: SectionType

    // MARK: Lifecycle
    init() {
        sectionType = .week
    }

    // MARK: Public functions
    func changeSectionType() {
        switch sectionType {
        case .week:
            sectionType = .month
        case .month:
            sectionType = .year
        case .year:
            sectionType = .week
        }
    }

    func createSection(dates: [Dates]) {
        for date in dates {
            date.section = nil
            let filter = dates.filter { $0.section == sectionType.sectionText(date: date) }
            if filter.isEmpty {
                date.section = sectionType.sectionText(date: date)
            }
        }
    }
}

// MARK: SectionType
extension HistoryViewModel {
    enum SectionType {
        case week
        case month
        case year

        var component: (first: Calendar.Component, second: Calendar.Component?) {
            switch self {
            case .week:
                return (first: .weekOfYear, second: .yearForWeekOfYear)
            case .month:
                return (first: .month, second: .year)
            case .year:
                return (first: .year, second: nil)
            }
        }

        func value(for date: Dates) -> (first: String, second: String) {
            guard let date = date.date else { return (first: "", second: "") }
            let firstValueFoSection = String(Calendar.current.component(self.component.first, from: date))
            let secondValueFoSection: String
            if let value = self.component.second {
                secondValueFoSection = "/" + String(Calendar.current.component(value, from: date))
            } else {
                secondValueFoSection = ""
            }
            return (first: firstValueFoSection, second: secondValueFoSection)
        }

        func sectionText(date: Dates) -> String {
            return "\(self.value(for: date).first)\(self.value(for: date).second)"
        }

        var name: String {
            switch self {
            case .week:
                return "week"
            case .month:
                return "month"
            case .year:
                return "year"
            }
        }
    }
}
