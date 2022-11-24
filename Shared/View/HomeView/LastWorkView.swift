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
            // Need to check coreDataManager.dates.count > 0,
            // because we have crash when we try to read date from core data
            if let last = viewModel.lastRecord, let date = last.date,
               let timeIn = last.timeIn, let timeOut = last.timeOut {
                Text("LAST WORK")
                    .font(.system(size: 12))
                    .foregroundColor(Color.theme.gray.opacity(0.8))
                    .padding(.leading)
                HStack {
                    Spacer()
                    VStack(spacing: 5) {
                        HStack { // hstack for date
                            Image.store.calendar
                                .foregroundColor(Color.theme.gray)
                            if last.night {
                                VStack {
                                    Text("From \(date, style: .date)")
                                    Text("Until \(date.plusOneDay() ?? Date(), style: .date)")
                                }
                            } else {
                                Text("\(date, style: .date)")
                            }
                        }
                        HStack(spacing: 10) { // hstack for timeIn and timeOut
                            HStack(spacing: 2) {
                                Image.store.arrowUpRight
                                    .foregroundColor(Color.theme.green)
                                Text("\(timeIn, style: .time)")
                            }
                            HStack(spacing: 2) {
                                Image.store.arrowUpLeft
                                    .foregroundColor(Color.theme.red)
                                Text("\(timeOut, style: .time)")
                            }
                        }
                        HStack(spacing: 10) { // hstack for secwork and secpause
                            HStack(spacing: 2) {
                                Image.store.hammer
                                    .foregroundColor(Color.theme.gray)
                                Text("\(last.secWork.toTimeString())")
                            }
                            HStack(spacing: 2) {
                                Image.store.pauseCircle
                                    .foregroundColor(Color.theme.gray)
                                Text("\(last.secPause.toTimeString())")
                            }
                        }
                    }// close VStack
                    Spacer()
                }
                .overlay(
                    HStack {
                        Rectangle()
                            .fill(Color.theme.accent)
                            .frame(width: 2)
                        Spacer()
                    }
                )
                .padding()
                .roundedBackgroundWithBorder
            }
        }
        .padding(.horizontal)
        .padding(.vertical, viewModel.padding)
        .onAppear {
            viewModel.loadLast(dates: coreDataManager.dates)
        }
        .onChange(of: viewModel.working) { _ in
            viewModel.loadLast(dates: coreDataManager.dates)
        }
    }
}

struct LastWorkView_Previews: PreviewProvider {
    static var previews: some View {
        LastWorkView()
    }
}
