//
//  HistoryTotalView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 30.03.21.
//

import SwiftUI

struct HistoryTotalView: View {
    let item: SumOfWeek
    var body: some View {
        HStack(spacing: 15) {
            Text("Total:")
                .foregroundColor(Color.theme.gray)
            VStack {
                HStack {
                    Image(systemName: "hammer.fill")
                        .foregroundColor(Color.theme.gray)
                    Text("\(item.secWork.toTimeString())")
                        .bold()
                    Image(systemName: "pause.circle")
                        .foregroundColor(Color.theme.gray)
                    Text("\(item.secPause.toTimeString())")
                        .bold()
                }
                .foregroundColor(Color.theme.accent)
                HStack {
                    if item.holidays > 0 {
                        Image(systemName: "case.fill")
                            .foregroundColor(Color.theme.gray)
                        Text("\(item.holidays) d")
                            .bold()
                        Spacer().frame(width: 20)
                    }
                    if item.publicHolidays > 0 {
                        Image(systemName: "flag.fill")
                            .foregroundColor(Color.theme.gray)
                        Text("\(item.publicHolidays) d")
                            .bold()
                        Spacer().frame(width: 20)
                    }
                    if item.sickness > 0 {
                        Image(systemName: "bandage.fill")
                            .foregroundColor(Color.theme.gray)
                        Text("\(item.sickness) d")
                            .bold()
                    }
                }
                .foregroundColor(Color.theme.accent)
            }
        }
    }
}
