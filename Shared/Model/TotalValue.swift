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

    init(date: Dates) {
        self.days = 1
        self.secWork = date.secWork
        self.secPause = date.secPause
        if let specialString = date.specialDay, let specialDay = SpecialDays(rawValue: specialString) {
            self.specialDays = [specialDay]
        } else {
            self.specialDays = []
        }
        self.lastDate = date
    }

    init(last: TotalValue, to new: TotalValue) {
        self.days = last.days + new.days
        self.secWork = last.secWork + new.secWork
        self.secPause = last.secPause + new.secPause
        self.specialDays = last.specialDays + new.specialDays

        // WARNING: We need take .lastDate from new property.
        // We need to save last date from section to show totalView in correct time.
        self.lastDate = new.lastDate
    }
}
