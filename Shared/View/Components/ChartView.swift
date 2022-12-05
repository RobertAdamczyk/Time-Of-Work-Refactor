//
//  ChartView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.12.22.
//

import SwiftUI
import Charts

struct ChartView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart {
                ForEach(coreDataManager.datesForChart.reversed(), id: \.self) { item in
                    BarMark(x: .value("Day", item.date.toString(format: .shortDate)),
                            y: .value("Hours", Double(item.secWork) / 3600))
                }
            }
            .padding(.horizontal, 40)
        } else {
            Spacer()
            Text("Update your iOS to version 16\n to see the charts here.")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.theme.gray)
            Spacer()
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
