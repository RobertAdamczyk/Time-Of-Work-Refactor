//
//  SumOfWeek.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 30.03.21.
//

import SwiftUI
import CoreData

class SumOfWeek: Identifiable {
    var id = UUID().uuidString
    var week: WeekAndYear
    var secWork: Int
    var secPause: Int
    var holidays: Int = 0
    var publicHolidays: Int = 0
    var sickness: Int = 0

    init(date: FetchedResults<Dates>.Element, week: WeekAndYear) {
        self.week = week
        self.secWork = date.secWork
        self.secPause = date.secPause
        if let special = date.specialDay {
            if let specialEnum = SpecialDays(rawValue: special) {
                switch specialEnum {
                case .holiday:
                    self.holidays += 1
                case .publicHoliday:
                    self.publicHolidays += 1
                case .sickness:
                    self.sickness += 1
                }
            }
        }
    }

    func add(date: FetchedResults<Dates>.Element) {
        self.secWork += date.secWork
        self.secPause += date.secPause
        if let special = date.specialDay {
            if let specialEnum = SpecialDays(rawValue: special) {
                switch specialEnum {
                case .holiday:
                    self.holidays += 1
                case .publicHoliday:
                    self.publicHolidays += 1
                case .sickness:
                    self.sickness += 1
                }
            }
        }
    }
}
