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
            showError = new.timeIn >= new.timeOut && !new.night
        }
        return new.timeIn < new.timeOut || new.night
    }
    
    func save(context: NSManagedObjectContext) {
        let newData = Dates(context: context)
        newData.date = new.date
        newData.timeIn = new.timeIn
        
        if new.night {
            if let timeOut = new.timeOut.plusOneDay() {
                newData.timeOut = timeOut
            }else {
                print("add date error")
                return
            }
        }else {
            newData.timeOut = new.timeOut
        }
        newData.pause = new.pause
        newData.night = new.night
        let dateNull = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: new.pause) // date null for calculate timeInterval between pause and 00:00
        if let dateNull = dateNull {
            let pause = Int(new.pause.timeIntervalSince(dateNull))
            newData.secPause = pause
            newData.secWork = Int(newData.timeOut.timeIntervalSince(newData.timeIn)) - pause
        }else {
            print("add date error")
            return
        }
        
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
