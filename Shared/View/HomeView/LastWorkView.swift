//
//  LastWorkView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 19.03.21.
//

import SwiftUI

struct LastWorkView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager

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
                        if coreDataManager.lastRecord?.night == true {
                            VStack {
                                Text("\(localized(string: "generic_from")) \(coreDataManager.lastRecord?.date ?? Date(), style: .date)")
                                Text("\(localized(string: "generic_until")) \(coreDataManager.lastRecord?.date.plusOneDay() ?? Date(), style: .date)")
                            }
                        } else {
                            Text("\(coreDataManager.lastRecord?.date ?? Date(), style: .date)")
                        }
                    }
                    HStack(spacing: 10) { // hstack for timeIn and timeOut
                        HStack(spacing: 2) {
                            ImageStore.arrowUpRight.image
                                .foregroundColor(Color.theme.green)
                            Text("\(coreDataManager.lastRecord?.timeIn ?? Date(), style: .time)")
                        }
                        HStack(spacing: 2) {
                            ImageStore.arrowUpLeft.image
                                .foregroundColor(Color.theme.red)
                            Text("\(coreDataManager.lastRecord?.timeOut ?? Date(), style: .time)")
                        }
                    }
                    HStack(spacing: 10) { // hstack for secwork and secpause
                        HStack(spacing: 2) {
                            ImageStore.hammer.image
                                .foregroundColor(Color.theme.gray)
                            Text("\(coreDataManager.lastRecord?.secWork.toTimeString() ?? "--:--")")
                        }
                        HStack(spacing: 2) {
                            ImageStore.pauseCircle.image
                                .foregroundColor(Color.theme.gray)
                            Text("\(coreDataManager.lastRecord?.secPause.toTimeString() ?? "--:--")")
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
        .opacity(coreDataManager.lastRecord == nil ? 0 : 1)
        .overlay(
            Text(localized(string: "home_start_first_work"))
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(Color.theme.gray)
                .opacity(coreDataManager.lastRecord == nil ? 1 : 0)
        )
        .padding(.horizontal, 40)
    }
}

struct LastWorkView_Previews: PreviewProvider {
    static var previews: some View {
        LastWorkView()
    }
}
