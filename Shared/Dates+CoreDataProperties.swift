//
//  Dates+CoreDataProperties.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//
//

import Foundation
import CoreData


extension Dates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dates> {
        return NSFetchRequest<Dates>(entityName: "Dates")
    }

    @NSManaged public var date: Date
    @NSManaged public var timeIn: Date
    @NSManaged public var timeOut: Date
    @NSManaged public var night: Bool
    @NSManaged public var pause: Date

}

extension Dates : Identifiable {

}
