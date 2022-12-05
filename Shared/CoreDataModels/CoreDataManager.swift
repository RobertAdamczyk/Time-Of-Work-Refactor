//
//  CoreDataViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 20.11.22.
//

import SwiftUI
import CoreData

class CoreDataManager: ObservableObject {

    // MARK: Published variables
    @Published var dates: [Dates] = []
    @Published var lastRecord: New?
    @Published var datesForChart: [New] = []

    // MARK: Private variables
    private let container: NSPersistentContainer

    // MARK: Lifeccle
    init() {
        container = NSPersistentCloudKitContainer(name: "TimeOfWorkCoreData")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error.description)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        fetchDates()
    }

    // MARK: Public functions
    func addDate(for new: New) {
        let newData = Dates(context: container.viewContext)
        newData.date = new.date
        newData.timeIn = new.timeIn

        if new.night {
            guard let timeOut = new.timeOut.plusOneDay() else { return }
            newData.timeOut = timeOut
            newData.secWork = Int(timeOut.timeIntervalSince(new.timeIn)) - new.secPause
        } else {
            newData.timeOut = new.timeOut
            newData.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
        }
        newData.night = new.night
        newData.secPause = new.secPause

        if let special = new.specialDay {
            newData.specialDay = special.rawValue
            newData.night = false
            newData.secPause = 0
            newData.secWork = Int(new.hoursSpecialDayInSec)
        }
        saveData()
    }

    func removeDate(date: Dates?) {
        guard let date = date else { return }
        container.viewContext.delete(date)
        saveData()
    }

    // MARK: Private functions
    private func fetchDates() {
        let request = NSFetchRequest<Dates>(entityName: "Dates")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            dates = try container.viewContext.fetch(request)
            loadLastRecord()
            loadDatesForChart()
        } catch let error {
            print("Error featch Dates: \(error)")
        }
    }

    private func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving coredata: \(error)")
        }
        fetchDates()
    }

    private func loadLastRecord() {
        if let last = dates.first, let date = last.date, let timeIn = last.timeIn, let timeOut = last.timeOut {
            lastRecord = New(date: date, timeIn: timeIn, timeOut: timeOut, secPause: last.secPause,
                             night: last.night, specialDay: SpecialDays(rawValue: last.specialDay ?? ""),
                             secWork: last.secWork)
        } else {
            lastRecord = nil
        }
    }

    private func loadDatesForChart() {
        datesForChart = []
        let timeIntervalLast6Days: TimeInterval = 6 * 24 * 3600
        let dateBefor6Days = Date().addingTimeInterval(-timeIntervalLast6Days)
        for item in dates {
            if let date = item.date, let timeIn = item.timeIn, let timeOut = item.timeOut,
               date > dateBefor6Days && date < Date().addingTimeInterval(-24 * 3600) {
                let new = New(date: date, timeIn: timeIn, timeOut: timeOut, secPause: item.secPause,
                              night: item.night, specialDay: SpecialDays(rawValue: item.specialDay ?? ""),
                              secWork: item.secWork)
                datesForChart.append(new)
            }
        }
        // loop to create fake 5 items.5
        // one item = one day
        for index in 1..<6 {
            let date = Date().addingTimeInterval(TimeInterval(-index * 24 * 3600))
            let new = New(date: date, timeIn: date, timeOut: date, secPause: 0,
                          night: false, specialDay: nil, secWork: 0)
            datesForChart.append(new)
        }
    }

    #if DEBUG
    func removeAllDates() {
        for date in dates {
            container.viewContext.delete(date)
        }
        saveData()
    }
    #endif
}
