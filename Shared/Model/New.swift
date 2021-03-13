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
    var secPause: Int
    var night: Bool
    
    init(){
        date = Date()
        timeIn = Date()
        timeOut = Date()
        secPause = 0
        night = false
    }
}

