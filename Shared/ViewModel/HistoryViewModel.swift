//
//  HistoryViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import Foundation
import SwiftUI
import CoreData

class HistoryViewModel: ObservableObject {
    @Published var showHeader = false
    @Published var weeksAndYears: [WeekAndYear] = []
    @Published var sumOfWeeks: [SumOfWeek] = []
    @Published var selectedDate: FetchedResults<Dates>.Element?
    @Published var editDate: Bool = false
    
    
    let refreshHistory = NotificationCenter.default.publisher(for:
              Notification.Name(rawValue: "RefreshHistory"))
    
    func loadArrays(array: FetchedResults<Dates>) {
        weeksAndYears.removeAll()
        for date in array {
            let week = Calendar.current.component(.weekOfYear, from: date.date)
            let year = Calendar.current.component(.yearForWeekOfYear, from: date.date)
            let newValue = WeekAndYear(weekOfYear: week, yearForWeekOfYear: year)
            if !weeksAndYears.contains(newValue){
                weeksAndYears.append(newValue)
            }
        }
    }
    
    func removeDate(date: FetchedResults<Dates>.Element, context: NSManagedObjectContext) {
        withAnimation{
            context.delete(date)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func weeklySum(array: FetchedResults<Dates>, week: WeekAndYear) -> (work: Int, pause: Int) {
        var sumWork = 0
        var sumPause = 0
        for date in array {
            if dateIsEqualWeekAndYear(date: date.date, value: week) {
                sumWork += date.secWork
                sumPause += date.secPause
            }
        }
        return (sumWork, sumPause)
    }
    
    func dateIsEqualWeekAndYear(date: Date, value: WeekAndYear) -> Bool{
        let week = Calendar.current.component(.weekOfYear, from: date)
        let year = Calendar.current.component(.yearForWeekOfYear, from: date)
        
        return week == value.weekOfYear && year == value.yearForWeekOfYear
    }
}
