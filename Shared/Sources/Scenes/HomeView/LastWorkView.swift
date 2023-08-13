//
//  LastWorkView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 19.03.21.
//

import SwiftUI

struct LastWorkView: View {
    @EnvironmentObject var viewModel: HomeViewModel

    private var lastWorkUnitDate: Date {
        viewModel.lastWorkUnit?.date ?? .now
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
                VStack(spacing: 5) {
                    Text(localized(string: "home_last_work"))
                        .font(.system(size: 12))
                        .foregroundColor(Color.theme.gray.opacity(0.8))
                        .padding(.leading)
                    HStack { // hstack for date
                        ImageStore.calendar.image
                            .foregroundColor(Color.theme.gray)
                        if viewModel.lastWorkUnit?.night == true {
                            VStack {
                                Text("\(localized(string: "generic_from")) \(lastWorkUnitDate, style: .date)")
                                Text("\(localized(string: "generic_until")) \(lastWorkUnitDate.plusOneDay() ?? .now, style: .date)")
                            }
                        } else {
                            Text("\(lastWorkUnitDate, style: .date)")
                        }
                    }
                    HStack(spacing: 10) { // hstack for timeIn and timeOut
                        HStack(spacing: 2) {
                            ImageStore.arrowUpRight.image
                                .foregroundColor(Color.theme.green)
                            Text("\(viewModel.lastWorkUnit?.timeIn ?? Date(), style: .time)")
                        }
                        HStack(spacing: 2) {
                            ImageStore.arrowUpLeft.image
                                .foregroundColor(Color.theme.red)
                            Text("\(viewModel.lastWorkUnit?.timeOut ?? Date(), style: .time)")
                        }
                    }
                    HStack(spacing: 10) { // hstack for secwork and secpause
                        HStack(spacing: 2) {
                            ImageStore.hammer.image
                                .foregroundColor(Color.theme.gray)
                            Text("\(viewModel.lastWorkUnit?.secWork.toTimeString() ?? "--:--")")
                        }
                        HStack(spacing: 2) {
                            ImageStore.pauseCircle.image
                                .foregroundColor(Color.theme.gray)
                            Text("\(viewModel.lastWorkUnit?.secPause.toTimeString() ?? "--:--")")
                        }
                    }
                }
                .padding(.horizontal, 20)
                .overlay(
                    HStack {
                        Rectangle()
                            .fill(Color.theme.accent)
                            .frame(width: 2)
                        Spacer()
                    }
                )
        }
        .opacity(viewModel.lastWorkUnit == nil ? 0 : 1)
        .overlay(
            Text(localized(string: "home_start_first_work"))
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(Color.theme.gray)
                .opacity(viewModel.lastWorkUnit == nil ? 1 : 0)
        )
        .padding(.horizontal, 40)
    }
}

struct LastWorkView_Previews: PreviewProvider {
    static var previews: some View {
        LastWorkView()
    }
}
