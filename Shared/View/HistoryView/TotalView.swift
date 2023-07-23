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
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
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
            HStack {
                Text("\(localized(string: "generic_days")): \(total.days)")
                Text("\(localized(string: "generic_work")): \(total.secWork.toTimeString())")
                Text("\(localized(string: "generic_pause")): \(total.secPause.toTimeString())")
                Spacer()
            }
            .foregroundColor(.theme.gray)
        }
        .font(
            .caption
            .weight(.semibold)
        )
    }
}
