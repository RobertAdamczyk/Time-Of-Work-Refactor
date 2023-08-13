//
//  TotalValue.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 27.11.22.
//

struct TotalValue: Hashable {
    var days: Int
    var secWork: Int
    var secPause: Int
    var specialDays: [SpecialDays]
    var lastDate: Dates
}
