//
//  DateOneDayLater.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 06.03.21.
//

import Foundation

extension Date {
    func plusOneDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}
