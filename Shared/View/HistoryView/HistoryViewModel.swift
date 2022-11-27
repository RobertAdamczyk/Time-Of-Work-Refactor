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
    @Published var total: [TotalValue] = [] // array with values for sums of week/month/year...

    // MARK: Lifecycle
    init() {
        sectionType = .week // TODO: Save to userDefaults ?
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

    /// Func to create sections und sums for history view
    func createSection(dates: [Dates]) {
        for date in dates {
            date.section = nil
        }
        total.removeAll()
        for date in dates {
            let filter = dates.filter { $0.section == sectionType.sectionText(date: date) }
            if filter.isEmpty {
                // We add section if not exist yet and we create first object of total
                date.section = sectionType.sectionText(date: date)
                total.append(TotalValue(date: date))
            } else {
                // If section already exist increacse only total value
                if let lastTotal = total.last, let lastIndex = total.lastIndex(of: lastTotal) {
                    total[lastIndex] = TotalValue(last: total[lastIndex], to: TotalValue(date: date))
                }
            }
        }
    }

    /// We check if next date has section value. If yes(date is lastone in section) show for current date totalView..
    func showTotalView(in dates: [Dates], for date: Dates) -> Bool {
        guard let index = dates.firstIndex(of: date) else { return false }
        if index + 1 < dates.count {
            let nextDate = dates[index+1]
            if nextDate.section != nil {
                return true
            } else {
                return false
            }
        } else {
            return true
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
