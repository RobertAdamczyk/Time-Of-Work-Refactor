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
    var hoursSpecialDay: Int = 8 // variable for hours sickness/holiday

    init() {
        date = Date()
        timeIn = Date()
        timeOut = Date()
        secPause = 0
        night = false
    }

    init(dates: [Dates]) { // only for LastDateView
        date = dates[0].date
        timeIn = dates[0].timeIn
        timeOut = dates[0].timeOut
        secPause = dates[0].secPause
        night = dates[0].night
        secWork = dates[0].secWork
        specialDay = SpecialDays(rawValue: dates[0].specialDay ?? "")
    }
}
