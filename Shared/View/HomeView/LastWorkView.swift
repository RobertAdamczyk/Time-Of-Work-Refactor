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
            if let last = viewModel.lastRecord, let secWork = last.secWork {
                VStack(spacing: 5) {
                    Text("LAST WORK")
                        .font(.system(size: 12))
                        .foregroundColor(Color.theme.gray.opacity(0.8))
                        .padding(.leading)
                    HStack { // hstack for date
                        Image.store.calendar
                            .foregroundColor(Color.theme.gray)
                        if last.night {
                            VStack {
                                Text("From \(last.date, style: .date)")
                                Text("Until \(last.date.plusOneDay() ?? Date(), style: .date)")
                            }
                        } else {
                            Text("\(last.date, style: .date)")
                        }
                    }
                    HStack(spacing: 10) { // hstack for timeIn and timeOut
                        HStack(spacing: 2) {
                            Image.store.arrowUpRight
                                .foregroundColor(Color.theme.green)
                            Text("\(last.timeIn, style: .time)")
                        }
                        HStack(spacing: 2) {
                            Image.store.arrowUpLeft
                                .foregroundColor(Color.theme.red)
                            Text("\(last.timeOut, style: .time)")
                        }
                    }
                    HStack(spacing: 10) { // hstack for secwork and secpause
                        HStack(spacing: 2) {
                            Image.store.hammer
                                .foregroundColor(Color.theme.gray)
                            Text("\(secWork.toTimeString())")
                        }
                        HStack(spacing: 2) {
                            Image.store.pauseCircle
                                .foregroundColor(Color.theme.gray)
                            Text("\(last.secPause.toTimeString())")
                        }
                    }
                }
                .padding(.horizontal, 40)
                .overlay(
                    HStack {
                        Rectangle()
                            .fill(Color.theme.accent)
                            .frame(width: 2)
                        Spacer()
                    }
                )
            }
        }
        .onAppear {
            viewModel.loadLast(dates: coreDataManager.dates)
        }
        .onChange(of: coreDataManager.dates) { _ in
            viewModel.loadLast(dates: coreDataManager.dates)
        }
    }
}

struct LastWorkView_Previews: PreviewProvider {
    static var previews: some View {
        LastWorkView()
    }
}
