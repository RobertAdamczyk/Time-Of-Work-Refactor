//
//  DateDayOfWeek.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 10.03.21.
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
