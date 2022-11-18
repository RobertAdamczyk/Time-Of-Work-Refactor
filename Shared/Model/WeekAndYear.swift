//
//  WeekAndYear.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import Foundation

struct WeekAndYear: Equatable, Hashable, Identifiable {
    let id = UUID().uuidString
    var weekOfYear: Int
    var yearForWeekOfYear: Int
    var beginOfWeek: Date
    var endOfWeek: Date
    var showWeek: Bool

    init(weekOfYear: Int, yearForWeekOfYear: Int) {
        self.weekOfYear = weekOfYear
        self.yearForWeekOfYear = yearForWeekOfYear

        // set begin and end of week
        let comps = DateComponents(weekOfYear: weekOfYear, yearForWeekOfYear: yearForWeekOfYear)
        self.beginOfWeek = Calendar.current.date(from: comps)!
        self.endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: beginOfWeek)!

        // bool for show/hide week in history view
        self.showWeek = false
    }

    static func == (lhs: WeekAndYear, rhs: WeekAndYear) -> Bool {
        lhs.weekOfYear == rhs.weekOfYear && lhs.yearForWeekOfYear == rhs.yearForWeekOfYear
    }
}
