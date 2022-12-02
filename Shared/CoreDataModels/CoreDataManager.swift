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
            newData.secWork = new.hoursSpecialDay * 3600
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
        }
    }
}
