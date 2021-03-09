//
//  AddDateViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import Foundation
import SwiftUI
import CoreData

class AddDateViewModel: ObservableObject {
    @Published var new = New()
    @Published var showComponent: ShowComponents?
    @Published var showError = false // error if timeIn is smaller then timeOut
    
    func changeShowComponent(newValue: ShowComponents?) {
        withAnimation{
            showComponent = showComponent == newValue ? nil : newValue // if old value is new value remove picker from screen
        }
    }
    
    func werifyDates() -> Bool{
        withAnimation{
            showError = new.timeIn >= new.timeOut
        }
        return new.timeIn < new.timeOut
    }
    
    func save(context: NSManagedObjectContext) {
        let newData = Dates(context: context)
        newData.date = new.date
        newData.timeIn = new.timeIn
        newData.timeOut = new.timeOut
        newData.pause = new.pause
        newData.night = new.night
        
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
