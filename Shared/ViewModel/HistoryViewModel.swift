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
    
    func loadArrays(array: FetchedResults<Dates>) {
        for date in array {
            let week = Calendar.current.component(.weekOfYear, from: date.date)
            let year = Calendar.current.component(.yearForWeekOfYear, from: date.date)
            let newValue = WeekAndYear(weekOfYear: week, yearForWeekOfYear: year)
            print(weeksAndYears)
            if !weeksAndYears.contains(newValue){
                weeksAndYears.append(newValue)
            }
        }
    }
    
    func dateIsEqualWeekAndYear(date: Date, value: WeekAndYear) -> Bool{
        let week = Calendar.current.component(.weekOfYear, from: date)
        let year = Calendar.current.component(.yearForWeekOfYear, from: date)
        
        return week == value.weekOfYear && year == value.yearForWeekOfYear
    }
}
