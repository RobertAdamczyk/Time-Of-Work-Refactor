//
//  Date.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 17.11.22.
//

import Foundation

extension Date {
    func toString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let string = dateFormatter.string(from: self)
        return string
    }
}

extension Date {
    func plusOneDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}
