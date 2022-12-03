//
//  Record.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import SwiftUI
struct New {
    var date: Date
    var timeIn: Date
    var timeOut: Date
    var secPause: Int
    var night: Bool
    var secWork: Int? // only for LastDateView
    var specialDay: SpecialDays?
    var hoursSpecialDayInSec: Double = 8 * 3600 // variable for hours sickness/holiday

    init() {
        date = Date()
        timeIn = Date()
        timeOut = Date()
        secPause = 0
        night = false
    }

    init(date: Date, timeIn: Date, timeOut: Date, secPause: Int, night: Bool, specialDay: SpecialDays?, secWork: Int) {
        self.date = date
        self.timeIn = timeIn
        self.timeOut = timeOut
        self.secPause = secPause
        self.night = night
        self.specialDay = specialDay
        self.secWork = secWork
    }
}
