//
//  TotalView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 27.11.22.
//

import SwiftUI

struct TotalView: View {
    @EnvironmentObject var viewModel: HistoryViewModel
    let date: Dates
    let total: TotalValue
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 0) {
                Text("Total of the \(viewModel.sectionType.name) ")
                Text("(\(viewModel.sectionType.sectionText(date: date))):")
                    .fontWeight(.bold)
            }
            .foregroundColor(.theme.accent)
            .font(
                .subheadline
                .weight(.semibold)
            )
            HStack {
                Text("Days: \(total.days)")
                Text("Work: \(total.secWork.toTimeString())")
                Text("Pause: \(total.secPause.toTimeString())")
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
