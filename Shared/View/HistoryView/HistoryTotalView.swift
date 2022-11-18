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
                    Image.store.hammer
                        .foregroundColor(Color.theme.gray)
                    Text("\(item.secWork.toTimeString())")
                        .bold()
                    Image.store.pauseCircle
                        .foregroundColor(Color.theme.gray)
                    Text("\(item.secPause.toTimeString())")
                        .bold()
                }
                .foregroundColor(Color.theme.accent)
                HStack {
                    if item.holidays > 0 {
                        Image.store.caseFill
                            .foregroundColor(Color.theme.gray)
                        Text("\(item.holidays) d")
                            .bold()
                        Spacer().frame(width: 20)
                    }
                    if item.publicHolidays > 0 {
                        Image.store.flag
                            .foregroundColor(Color.theme.gray)
                        Text("\(item.publicHolidays) d")
                            .bold()
                        Spacer().frame(width: 20)
                    }
                    if item.sickness > 0 {
                        Image.store.bandage
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
