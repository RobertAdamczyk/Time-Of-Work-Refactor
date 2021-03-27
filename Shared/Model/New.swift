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
    
    var holiday: Bool
    var publicHoliday: Bool
    var sickness: Bool
    
    init(){
        date = Date()
        timeIn = Date()
        timeOut = Date()
        secPause = 0
        night = false
        
        holiday = false
        publicHoliday = false
        sickness = false
    }
    
    init(result: FetchedResults<Dates>) { // only for LastDateView
        date = result[0].date
        timeIn = result[0].timeIn
        timeOut = result[0].timeOut
        secPause = result[0].secPause
        night = result[0].night
        secWork = result[0].secWork
        
        holiday = result[0].holiday
        publicHoliday = result[0].publicHoliday
        sickness = result[0].sickness
    }
}

