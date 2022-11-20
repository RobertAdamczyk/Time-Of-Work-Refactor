//
//  HistoryViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import Foundation
import SwiftUI
import CoreData

class HistoryViewModel: ObservableObject {
    @Published var showHeader = false
    @Published var weeksAndYears: [WeekAndYear] = []
    @Published var sumOfWeeks: [SumOfWeek] = []
    @Published var selectedDate: Dates?
    @Published var editDate: Bool = false

    let refreshHistory = NotificationCenter.default.publisher(for:
              Notification.Name(rawValue: "RefreshHistory"))

    func loadArrays(array: [Dates]) {
        weeksAndYears.removeAll()
        sumOfWeeks.removeAll()
        for date in array {
            let week = Calendar.current.component(.weekOfYear, from: date.date)
            let year = Calendar.current.component(.yearForWeekOfYear, from: date.date)
            let newValue = WeekAndYear(weekOfYear: week, yearForWeekOfYear: year)
            if !weeksAndYears.contains(newValue) {
                weeksAndYears.append(newValue)
                weeklySum(date: date, week: newValue, contains: false)
            } else {
                weeklySum(date: date, week: newValue, contains: true)
            }
        }
    }

    func weeklySum(date: Dates, week: WeekAndYear, contains: Bool) {
        if contains {
            sumOfWeeks.last?.add(date: date)
        } else {
            sumOfWeeks.append(SumOfWeek(date: date, week: week))
        }
    }

    func dateIsEqualWeekAndYear(date: Date, value: WeekAndYear) -> Bool {
        let week = Calendar.current.component(.weekOfYear, from: date)
        let year = Calendar.current.component(.yearForWeekOfYear, from: date)

        return week == value.weekOfYear && year == value.yearForWeekOfYear
    }
}
