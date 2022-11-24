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

    func editDate(date: Dates, for new: New) {
        date.date = new.date
        date.timeIn = new.timeIn

        if new.night == date.night { // if not changed
            date.timeOut = new.timeOut
            date.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
        } else { // if user changed work at night
            if let timeOut = Calendar.current.date(byAdding: .day, value: new.night ? 1 : -1, to: new.timeOut) {
                date.timeOut = timeOut
                date.secWork = Int(timeOut.timeIntervalSince(new.timeIn)) - new.secPause
            }
        }
        date.night = new.night
        date.secPause = new.secPause

        if let special = new.specialDay {
            date.specialDay = special.rawValue
            date.night = false
            date.secPause = 0
            date.secWork = new.hoursSpecialDay * 3600
        } else {
            date.specialDay = nil
        }
        saveData()
    }

    func removeDate(date: Dates) {
        withAnimation {
            container.viewContext.delete(date)
            saveData()
        }
    }

    // MARK: Private functions
    private func fetchDates() {
        let request = NSFetchRequest<Dates>(entityName: "Dates")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            dates = try container.viewContext.fetch(request)
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
}
