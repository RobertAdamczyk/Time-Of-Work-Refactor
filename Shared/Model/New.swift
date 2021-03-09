//
//  Record.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import Foundation
struct New {
    var date: Date
    var timeIn: Date
    var timeOut: Date
    var pause: Date
    var night: Bool
    
    init(){
        date = Date()
        timeIn = Date()
        timeOut = Date()
        pause = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        night = false
    }
}

