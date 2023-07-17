//
//  CoreDataService.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.07.23.
//

import CoreData

final class CoreDataService {

    @Published private(set) var workUnits: [WorkUnit] = []

    // MARK: Private variables
    private let container: NSPersistentContainer

    // MARK: Lifecycle
    init() {
        container = NSPersistentCloudKitContainer(name: "TimeOfWorkCoreData")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error.description)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        fetchWorkUnits()
    }

    // MARK: Public functions
    func addWorkUnit(for new: New) {
        let newData = WorkUnit(context: container.viewContext)
        newData.date = new.date
        newData.timeIn = new.timeIn

        // in home view works work at night without if statement
        // if statement is for add/edit view
        let sameDayForInOut = Calendar.current.component(.day, from: new.timeIn) ==
                              Calendar.current.component(.day, from: new.timeOut)
        if new.night {
            if sameDayForInOut, let timeOut = new.timeOut.plusOneDay() {
                newData.timeOut = timeOut
                newData.secWork = Int(timeOut.timeIntervalSince(new.timeIn)) - new.secPause
            } else {
                newData.timeOut = new.timeOut
                newData.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
            }

        } else {
            if !sameDayForInOut, let timeOut = new.timeOut.minusOneDay() {
                newData.timeOut = timeOut
                newData.secWork = Int(timeOut.timeIntervalSince(new.timeIn)) - new.secPause
            } else {
                newData.timeOut = new.timeOut
                newData.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
            }

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

    func removeWorkUnit(_ unit: WorkUnit?) {
        guard let unit else { return }
        container.viewContext.delete(unit)
        saveData()
    }

    func fetchWorkUnits() {
        let request = NSFetchRequest<Dates>(entityName: "Dates")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            self.workUnits = try container.viewContext.fetch(request)
        } catch let error {
            print("Error saving coredata: \(error)")
        }
    }

    private func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving coredata: \(error)")
        }
        fetchWorkUnits()
    }

    #if DEBUG
    func removeAllDates() {
        for unit in workUnits {
            container.viewContext.delete(unit)
        }
        saveData()
    }
    #endif
}
