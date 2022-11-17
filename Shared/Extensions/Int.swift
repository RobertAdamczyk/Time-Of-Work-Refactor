//
//  DoubleToTime.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 10.03.21.
//

extension Int {
    func toTimeString() -> String {
        let positive = abs(self)
        let min = positive % 3600 / 60
        let hour = positive / 3600

        let hourString = "\(hour)h "
        let minString = "\(min)m"
        return self < 0 ? "-" + hourString + minString : hourString + minString
    }
}
