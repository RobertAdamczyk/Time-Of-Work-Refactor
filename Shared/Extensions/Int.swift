//
//  DoubleToTime.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 10.03.21.
//

extension Int {
    func toTimeString() -> String {
        let positive = abs(self)
        let sec = positive % 3600 % 60
        let min = positive % 3600 / 60
        let hour = positive / 3600

        let hourString = "\(hour)h "
        let minString = "\(min)m"
        let secString = " \(sec)s"
        let completeString = hour == 0 ? minString + secString : hourString + minString
        return self < 0 ? "-" + completeString : completeString
    }

    func toTimeStringTimerFormat() -> String {
        let positive = abs(self)
        let hour = positive / 3600
        let min = positive % 3600 / 60
        let sec = positive % 3600 % 60

        let hourString = hour == 0 ? "" : "\(hour)h "
        let minString = "\(min)m "
        let secString = sec < 10 ? "0\(sec)s" : "\(sec)s"

        let timeInString = hourString + minString + secString
        return self < 0 ? "-" + timeInString : timeInString
    }
}
