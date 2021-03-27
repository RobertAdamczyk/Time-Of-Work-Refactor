//
//  Dates+CoreDataProperties.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 27.03.21.
//
//

import Foundation
import CoreData


extension Dates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dates> {
        return NSFetchRequest<Dates>(entityName: "Dates")
    }

    @NSManaged public var date: Date
    @NSManaged public var night: Bool
    @NSManaged public var secPause: Int
    @NSManaged public var secWork: Int
    @NSManaged public var timeIn: Date
    @NSManaged public var timeOut: Date
    @NSManaged public var holiday: Bool
    @NSManaged public var publicHoliday: Bool
    @NSManaged public var sickness: Bool

}

extension Dates : Identifiable {

}
