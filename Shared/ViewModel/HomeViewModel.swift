//
//  HomeViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 13.03.21.
//

import Foundation
import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {

    @Published var currentTime: Int = 0
    @Published var showComponent: ShowComponents?
    @Published var lastRecord: New?
    @AppStorage("pause") var pause: Int = 0
    var lastDate: Date = UserDefaults.standard.object(forKey: "lastDate") as? Date ?? Date()
    @Published var working: Bool = UserDefaults.standard.bool(forKey: "working")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var height = UIScreen.main.bounds.height // for circle size in nowView
    var padding: CGFloat { // for home views for smaller iphones
        if UIScreen.main.bounds.height < 700 {
            return 0
        } else {
            return 20
        }
    }

    func setLastDate(value: Date) {
        lastDate = value
        UserDefaults.standard.set(value, forKey: "lastDate")
    }
    func toggleWorking() {
        withAnimation {
            working.toggle()
            UserDefaults.standard.set(working, forKey: "working")
        }
    }
    func changeShowComponent(newValue: ShowComponents?) {
        withAnimation {
            // if old value is new value remove picker from screen
            showComponent = showComponent == newValue ? nil : newValue
        }
    }

    func refreshWorkTime() {
        currentTime = Int(Date().timeIntervalSince(lastDate)) - pause
    }

    func createNewRecordForEndWork() -> New {
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

    func loadLast(dates: [Dates]) {
        withAnimation {
            if dates.count > 0 {
                lastRecord = New(dates: dates)
            } else {
                lastRecord = nil
                return
            }
        }
    }

    func checkCurrentWork() { // if user forgot stop working
        if working && abs(lastDate.timeIntervalSince(Date())) > 3600 * 48 {
            toggleWorking()
        }
    }
}
