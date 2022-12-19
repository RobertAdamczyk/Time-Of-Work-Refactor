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
    func minusOneDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
}

/// AppStorage wrapper supports objects that conform to RawRepresentable protocol,
/// where that raw value is a String or Int.
extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()

    public var rawValue: String {
        Date.formatter.string(from: self)
    }

    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
