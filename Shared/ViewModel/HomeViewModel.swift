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
    @Published var showComponent: ShowComponents?
    @Published var lastRecord: New?
    @AppStorage("pause") var pause: Int = 0
    var lastDate: Date = UserDefaults.standard.object(forKey: "lastDate") as? Date ?? Date()
    @Published var working: Bool = UserDefaults.standard.bool(forKey: "working")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var height = UIScreen.main.bounds.height // for circle size in nowView
    var padding : CGFloat { // for home views for smaller iphones
        if UIScreen.main.bounds.height < 700 {
            return 0
        }else {
            return 20
        }
    }
    
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
    func changeShowComponent(newValue: ShowComponents?) {
        withAnimation{
            showComponent = showComponent == newValue ? nil : newValue // if old value is new value remove picker from screen
        }
    }
    
    func refreshWorkTime() {
        currentTime = Int(Date().timeIntervalSince(lastDate)) - pause
    }
    
    func endWork(context: NSManagedObjectContext) {
        let newData = Dates(context: context)
        newData.date = lastDate
        newData.timeIn = lastDate
        newData.timeOut = Date()
        newData.secPause = pause
        newData.secWork = Int(newData.timeOut.timeIntervalSince(newData.timeIn)) - newData.secPause
        newData.night = Calendar.current.component(.day, from: newData.timeIn) != Calendar.current.component(.day, from: newData.timeOut)
        
        newData.specialDay = nil
        
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadLast(result: FetchedResults<Dates>) {
        withAnimation{
            if result.count > 0 {
                lastRecord = New(result: result)
            }else {
                lastRecord = nil
                return
            }
        }
    }
    
}
