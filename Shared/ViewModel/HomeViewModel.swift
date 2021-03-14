//
//  HomeViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 13.03.21.
//

import Foundation
import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var currentTime: Int = 0
    @Published var showPausePicker = false
    @AppStorage("pause") var pause: Int = 0
    var lastDate: Date = UserDefaults.standard.object(forKey: "lastDate") as? Date ?? Date()
    @Published var working: Bool = UserDefaults.standard.bool(forKey: "working")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    func setLastDate(value: Date) {
        lastDate = value
        UserDefaults.standard.set(value, forKey: "lastDate")
    }
    func toggleWorking() {
        withAnimation{
            working.toggle()
            UserDefaults.standard.set(working, forKey: "working")
        }
    }
    
    func refreshWorkTime() {
        withAnimation{
            currentTime = Int(Date().timeIntervalSince(lastDate)) - pause
        }
        
    }
    
    func endWork(context: NSManagedObjectContext) {
        let newData = Dates(context: context)
        newData.date = lastDate
        newData.timeIn = Calendar.current.date(bySetting: .second, value: 0, of: lastDate) ?? lastDate
        newData.timeOut = Calendar.current.date(bySetting: .second, value: 0, of: Date()) ?? Date()
        newData.secPause = pause
        newData.secWork = Int(newData.timeOut.timeIntervalSince(newData.timeIn)) - newData.secPause
        newData.night = Calendar.current.component(.day, from: newData.timeIn) != Calendar.current.component(.day, from: newData.timeOut)
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}
