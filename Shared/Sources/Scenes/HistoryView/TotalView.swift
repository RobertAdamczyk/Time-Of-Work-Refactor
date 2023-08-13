//
//  TotalView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 27.11.22.
//

import SwiftUI

struct TotalView: View {
    @EnvironmentObject var viewModel: HistoryViewModel
    let workUnit: WorkUnit
    let total: TotalValue

    private var shouldShowSpecialDaysRow: Bool {
        !total.specialDays.isEmpty
    }

    private var holidaysCount: Int {
        total.specialDays.filter({ $0 == .holiday }).count
    }

    private var publicHolidaysCount: Int {
        total.specialDays.filter({ $0 == .publicHoliday }).count
    }

    private var sicknessCount: Int {
        total.specialDays.filter({ $0 == .sickness }).count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Text("\(localized(string: "history_total_of")) \(viewModel.sectionType.name) ")
                Text("(\(viewModel.sectionType.sectionText(for: workUnit))):")
                    .fontWeight(.bold)
            }
            .foregroundColor(.theme.accent)
            .font(
                .subheadline
                .weight(.semibold)
            )
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("\(localized(string: "generic_days")): \(total.days)")
                    Text("\(localized(string: "generic_work")): \(total.secWork.toTimeString())")
                    Text("\(localized(string: "generic_pause")): \(total.secPause.toTimeString())")
                    Spacer()
                }
                .foregroundColor(.theme.gray)
                if shouldShowSpecialDaysRow {
                    HStack {
                        Text("\(localized(string: "add_edit_vacation")): \(holidaysCount)")
                        Text("\(localized(string: "add_edit_public_holiday")): \(publicHolidaysCount)")
                        Text("\(localized(string: "add_edit_sickness")): \(sicknessCount)")
                        Spacer()
                    }
                    .foregroundColor(.theme.gray)
                }
            }
        }
        .font(
            .caption
            .weight(.semibold)
        )
    }
}
