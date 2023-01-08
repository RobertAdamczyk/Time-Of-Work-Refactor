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
            if coreDataManager.uniqueDatesForChartCount < 5 {
                Spacer()
                Text(localized(string: "chart_more_data_needed"))
                    .frame(width: 200)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
                    .foregroundColor(.theme.gray)
                Spacer()
            } else {
                Chart {
                    ForEach(coreDataManager.datesForChart.reversed(), id: \.self) { item in
                        BarMark(x: .value(localized(string: "generic_day"), item.date.toString(format: .shortDate)),
                                y: .value(localized(string: "generic_hours"), Double(item.secWork) / 3600))
                    }
                }
                .padding(.horizontal, 40)
            }
        } else {
            Spacer()
            Text(localized(string: "chart_update_os"))
                .frame(width: 200)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
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
