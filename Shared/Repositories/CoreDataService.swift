//
//  CoreDataService.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import CoreData

final class CoreDataService {

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
        //fetchDates()
    }

//    // MARK: Public functions
//    func addDate(for new: New) {
//        let newData = Dates(context: container.viewContext)
//        newData.date = new.date
//        newData.timeIn = new.timeIn
//
//        // in home view works work at night without if statement
//        // if statement is for add/edit view
//        let sameDayForInOut = Calendar.current.component(.day, from: new.timeIn) ==
//                              Calendar.current.component(.day, from: new.timeOut)
//        if new.night {
//            if sameDayForInOut, let timeOut = new.timeOut.plusOneDay() {
//                newData.timeOut = timeOut
//                newData.secWork = Int(timeOut.timeIntervalSince(new.timeIn)) - new.secPause
//            } else {
//                newData.timeOut = new.timeOut
//                newData.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
//            }
//
//        } else {
//            if !sameDayForInOut, let timeOut = new.timeOut.minusOneDay() {
//                newData.timeOut = timeOut
//                newData.secWork = Int(timeOut.timeIntervalSince(new.timeIn)) - new.secPause
//            } else {
//                newData.timeOut = new.timeOut
//                newData.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
//            }
//
//        }
//        newData.night = new.night
//        newData.secPause = new.secPause
//
//        if let special = new.specialDay {
//            newData.specialDay = special.rawValue
//            newData.night = false
//            newData.secPause = 0
//            newData.secWork = Int(new.hoursSpecialDayInSec)
//        }
//        saveData()
//    }
//
//    func removeDate(date: Dates?) {
//        guard let date = date else { return }
//        container.viewContext.delete(date)
//        saveData()
//    }
//
//    // MARK: Private functions
//    private func fetchDates() {
//        let request = NSFetchRequest<Dates>(entityName: "Dates")
//        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//        do {
//            dates = try container.viewContext.fetch(request)
//            loadLastRecord()
//            loadDatesForChart()
//        } catch let error {
//            print("Error featch Dates: \(error)")
//        }
//    }
//
//    private func saveData() {
//        do {
//            try container.viewContext.save()
//        } catch let error {
//            print("Error saving coredata: \(error)")
//        }
//        fetchDates()
//    }
//
//    private func loadLastRecord() {
//        if let last = dates.first, let date = last.date, let timeIn = last.timeIn, let timeOut = last.timeOut {
//            lastRecord = New(date: date, timeIn: timeIn, timeOut: timeOut, secPause: last.secPause,
//                             night: last.night, specialDay: SpecialDays(rawValue: last.specialDay ?? ""),
//                             secWork: last.secWork)
//        } else {
//            lastRecord = nil
//        }
//    }
//
//    private func loadDatesForChart() {
//        datesForChart = []
//        var uniqueDates: [String] = []
//        let calendar = Calendar.current
//        dates.forEach { item in
//            guard uniqueDates.count < 5 else { return }
//            if let date = item.date, let timeIn = item.timeIn, let timeOut = item.timeOut {
//                let new = New(date: date, timeIn: timeIn, timeOut: timeOut, secPause: item.secPause,
//                              night: item.night, specialDay: SpecialDays(rawValue: item.specialDay ?? ""),
//                              secWork: item.secWork)
//                let day = String(calendar.component(.day, from: date))
//                let month = String(calendar.component(.month, from: date))
//                let year = String(calendar.component(.year, from: date))
//                let string = day + month + year
//                datesForChart.append(new)
//                if !uniqueDates.contains(string) {
//                    uniqueDates.append(string)
//                }
//            }
//        }
//        uniqueDatesForChartCount = uniqueDates.count
//    }
//
//    #if DEBUG
//    func removeAllDates() {
//        for date in dates {
//            container.viewContext.delete(date)
//        }
//        saveData()
//    }
//    #endif
}
