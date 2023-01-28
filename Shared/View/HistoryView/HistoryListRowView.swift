//
//  HistoryListRowView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 27.11.22.
//

import SwiftUI

struct HistoryListRowView: View {
    let value: Dates
    var body: some View {
        HStack(spacing: 0) {
            if let timeIn = value.timeIn, let timeOut = value.timeOut, let date = value.date {
                VStack(alignment: .leading) {
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
                .frame(width: Config.screenWidth * 0.28, alignment: .leading)
                Spacer()
                if let specialDay = value.specialDay {
                    HStack {
                        Text("\(specialDay)")
                        if let special = SpecialDays(rawValue: specialDay) {
                            special.image
                                .foregroundColor(Color.theme.gray)
                        }
                    }
                } else {
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("\(timeIn, style: .time)")
                            ImageStore.arrowUpLeft.image
                                .foregroundColor(Color.theme.green)
                        }
                        HStack {
                            Text("\(timeOut, style: .time)")
                            ImageStore.arrowUpRight.image
                                .foregroundColor(Color.theme.red)
                        }
                    }
                }
                Spacer()
                HStack {
                    VStack(alignment: .trailing) {
                        Text("\(value.secWork.toTimeString())")
                        if value.specialDay == nil { Text("\(value.secPause.toTimeString())") }
                    }
                    VStack {
                        ImageStore.hammer.image
                        if value.specialDay == nil { ImageStore.pauseCircle.image }
                    }
                    .foregroundColor(Color.theme.gray)
                }
                .frame(width: Config.screenWidth * 0.28, alignment: .trailing)
            }
        }
        .font(.headline)
    }
}
