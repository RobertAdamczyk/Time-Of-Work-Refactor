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

    // If user have a lot of data view needs time to load
    @Published var state: State

    // MARK: Lifecycle
    init() {
        sectionType = .week // TODO: Save to userDefaults ?
        state = .loading
    }

    // MARK: Public functions

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

    func onSectionButtonTapped(dates: [Dates]) {
        state = .loading
        DispatchQueue.main.async { [weak self] in
            self?.changeSectionType()
            self?.createSection(dates: dates)
        }
    }

    func onViewAppear(dates: [Dates]) {
        state = .loading
        DispatchQueue.main.async { [weak self] in
            self?.createSection(dates: dates)
        }
    }

    func onChangeDates(dates: [Dates]) {
        state = .loading
        DispatchQueue.main.async { [weak self] in
            self?.createSection(dates: dates)
        }
    }

    // MARK: Private functions
    private func changeSectionType() {
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
    private func createSection(dates: [Dates]) {
        DispatchQueue.main.async { [weak self] in
            for date in dates {
                date.section = nil
            }
            self?.total.removeAll()
            for date in dates {
                let filter = dates.filter { $0.section == self?.sectionType.sectionText(date: date) }
                if filter.isEmpty {
                    // We add section if not exist yet and we create first object of total
                    date.section = self?.sectionType.sectionText(date: date)
                    self?.total.append(TotalValue(date: date))
                } else {
                    // If section already exist increacse only total value
                    if let lastTotal = self?.total.last, let lastIndex = self?.total.lastIndex(of: lastTotal) {
                        self?.total[lastIndex] = TotalValue(last: lastTotal, to: TotalValue(date: date))
                    }
                }
            }
            self?.state = .idle
        }
    }
}

// MARK: State
extension HistoryViewModel {
    enum State {
        case loading
        case idle
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
