//
//  HomeViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.11.22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @AppStorage("pause") var pause: Int = 0

    // MARK: Published variables
    @Published var currentWorkTimeInSec: Int = 0
    @Published var lastRecord: New?
    @Published var working: Bool = UserDefaults.standard.bool(forKey: "working")
    @Published var lastDate: Date = UserDefaults.standard.object(forKey: "lastDate") as? Date ?? Date()
    @Published var currentCell: HomeCell = .idle

    // MARK: Public variables
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    init() {
        self.currentCell = working ? .working : .idle
    }

    // MARK: Public functions
    func onSwipeButton(action: (() -> Void)? = nil) {
        if working {
            action?()
        }
        setLastDate(value: Date())
        refreshWorkTime()
        toggleWorking()
    }

    func setLastDate(value: Date) {
        lastDate = value
        UserDefaults.standard.set(value, forKey: "lastDate")
    }

    func loadLast(dates: [Dates]) {
        if let last = dates.first, let date = last.date, let timeIn = last.timeIn, let timeOut = last.timeOut {
            lastRecord = New(date: date, timeIn: timeIn, timeOut: timeOut, secPause: last.secPause,
                             night: last.night, specialDay: SpecialDays(rawValue: last.specialDay ?? ""),
                             secWork: last.secWork)
        }
    }

    func refreshWorkTime() {
        currentWorkTimeInSec = Int(Date().timeIntervalSince(lastDate)) - pause
    }

    func createNewDateForEndWork() -> New {
        var new = New()
        new.date = lastDate
        new.timeIn = lastDate
        new.timeOut = Date()
        new.secPause = pause
        new.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
        new.night = Calendar.current.component(.day, from: new.timeIn) !=
                    Calendar.current.component(.day, from: new.timeOut)
        new.specialDay = nil
        return new
    }

    func checkCurrentWork() { // if user forgot stop working
        if working && abs(lastDate.timeIntervalSince(Date())) > 3600 * 24 {
            toggleWorking()
        }
    }

    // MARK: Private functions
    private func toggleWorking() {
        working.toggle()
        UserDefaults.standard.set(working, forKey: "working")
        withAnimation(.easeInOut(duration: 1)) {
            self.currentCell = working ? .working : .idle
        }
    }
}
