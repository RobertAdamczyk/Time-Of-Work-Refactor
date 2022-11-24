//
//  HistoryRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import SwiftUI

struct HistoryRow: View {
    var value: Dates
    var width = UIScreen.main.bounds.width * 0.27
    var body: some View {
        if let date = value.date, let timeIn = value.timeIn, let timeOut = value.timeOut {
            HStack(spacing: 0) {
                HStack {
                    VStack {
                        if value.night {
                            Text("\(date.toString(format: .dayOnlyShort))-" +
                                 "\(date.plusOneDay()!.toString(format: .dayOnlyShort))")
                            Text("\(date.toString(format: .dayOnlyNumber))-" +
                                 "\(date.plusOneDay()!.toString(format: .shortDate))")
                        } else {
                            Text("\(date.toString(format: .dayOnly))")
                            Text("\(date.toString(format: .shortDate))")
                        }
                    }
                }
                .frame(width: width-5)
                Spacer()
                if let specialDay = value.specialDay {
                    HistorySpecialDayView(value: specialDay)
                        .frame(width: width+5)
                } else {
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("\(timeIn, style: .time)")
                            Image.store.arrowUpLeft
                                .foregroundColor(Color.theme.green)
                        }
                        HStack {
                            Text("\(timeOut, style: .time)")
                            Image.store.arrowUpRight
                                .foregroundColor(Color.theme.red)
                        }
                    }
                    .frame(width: width+5)
                }
                Spacer()
                HStack {
                    VStack {
                        Text("\(value.secWork.toTimeString())")
                        if value.specialDay == nil { Text("\(value.secPause.toTimeString())") }
                    }
                    VStack {
                        Image.store.hammer
                        if value.specialDay == nil { Image.store.pauseCircle }
                    }
                    .foregroundColor(Color.theme.gray)
                }
                .frame(width: width+5)
            }
            .overlay(
                HStack {
                    Rectangle()
                        .frame(width: 2)
                        .padding(.vertical, 3)
                        .foregroundColor(Color.theme.accent)
                        .padding(.leading, 3)
                    Spacer()
                }
            )
            .padding(.horizontal, 5)
            .padding(.vertical, 3)
        } else {
            EmptyView()
        }
    }
}
