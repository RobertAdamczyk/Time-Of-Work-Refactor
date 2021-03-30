//
//  HistorySpecialDayView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 30.03.21.
//

import SwiftUI

struct HistorySpecialDayView: View {
    var value : FetchedResults<Dates>.Element
    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                Text("\(value.specialDay!)")
                Image(systemName: value.specialDay != SpecialDays.sickness
                    .rawValue ? "case.fill" : "bandage.fill")
                    .foregroundColor(.gray)
            }
        }
    }
}
