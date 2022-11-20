//
//  Dates+CoreDataProperties.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 28.03.21.
//
//

import Foundation
import CoreData

extension Dates {

    @NSManaged public var date: Date
    @NSManaged public var night: Bool
    @NSManaged public var secPause: Int
    @NSManaged public var secWork: Int
    @NSManaged public var specialDay: String?
    @NSManaged public var timeIn: Date
    @NSManaged public var timeOut: Date

}

extension Dates: Identifiable {

}
