//
//  HistoryRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import SwiftUI

struct HistoryRow: View {
    var value : FetchedResults<Dates>.Element
    var body: some View {
        VStack{
            HStack{
                Text("\(value.date.dayOfWeek())") // dayOfWeek is in extension folder
                Text("\(value.date, style: .date)")
                Spacer()
            }
            HStack{
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .foregroundColor(.green)
                Text("\(value.timeIn, style: .time)")
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .foregroundColor(.red)
                Text("\(value.timeOut, style: .time)")
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 3)
    }
}

