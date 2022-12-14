//
//  Persistence.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 07.03.21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TimeOfWorkCoreData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error.description)")
            }
        }
    }
}
