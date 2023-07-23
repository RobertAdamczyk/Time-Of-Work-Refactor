//
//  HistoryListRowView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 27.11.22.
//

import SwiftUI

struct HistoryListRowView: View {

    @EnvironmentObject var viewModel: HistoryViewModel

    let previousWorkUnit: WorkUnit?
    let workUnit: WorkUnit
    let nextWorkUnit: WorkUnit?

    var shouldShowSection: Bool {
        guard let previousDate = previousWorkUnit?.date, let currentDate = workUnit.date else { return true }
        let firstCondition = Calendar.current.isDate(previousDate, equalTo: currentDate,
                                                     toGranularity: viewModel.sectionType.components.first)
        if let second = viewModel.sectionType.components.second {
            let secondCondition = Calendar.current.isDate(previousDate, equalTo: currentDate, toGranularity: second)
            return !(firstCondition && secondCondition)
        } else {
            return !firstCondition
        }
    }

    var shouldShowTotalView: Bool {
        guard let nextDate = nextWorkUnit?.date, let currentDate = workUnit.date else { return true }
        let firstCondition = Calendar.current.isDate(nextDate, equalTo: currentDate,
                                                     toGranularity: viewModel.sectionType.components.first)
        if let second = viewModel.sectionType.components.second {
            let secondCondition = Calendar.current.isDate(nextDate, equalTo: currentDate, toGranularity: second)
            return !(firstCondition && secondCondition)
        } else {
            return !firstCondition
        }
    }

    var total: TotalValue {
        let units = viewModel.workUnits.filter { unit in
            guard let unitDate = unit.date, let currentDate = workUnit.date else { return false }
            let firstCondition = Calendar.current.isDate(unitDate, equalTo: currentDate,
                                                         toGranularity: viewModel.sectionType.components.first)
            if let second = viewModel.sectionType.components.second {
                let secondCondition = Calendar.current.isDate(unitDate, equalTo: currentDate, toGranularity: second)
                return (firstCondition && secondCondition)
            } else {
                return firstCondition
            }
        }
        let secWork = units.compactMap({ $0.secWork }).reduce(0, +)
        let secPause = units.compactMap({ $0.secPause }).reduce(0, +)
        let specialDays = units.compactMap({ SpecialDays(rawValue: $0.specialDay ?? "") })
        return .init(days: units.count, secWork: secWork, secPause: secPause,
                     specialDays: specialDays, lastDate: workUnit)
    }

    var body: some View {
        VStack(spacing: 16) {
            if shouldShowSection {
                HStack {
                    Text(viewModel.sectionType.sectionText(for: workUnit))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.theme.gray)
                    Spacer()
                }
                .padding(.top, 10)
            }
            workUnitRow
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.onHistoryRowTapped(date: workUnit)
                }
            if shouldShowTotalView {
                TotalView(workUnit: workUnit, total: total)
            }
            Divider()
        }
    }

    @ViewBuilder
    private var workUnitRow: some View {
        HStack(spacing: 0) {
            if let timeIn = workUnit.timeIn, let timeOut = workUnit.timeOut, let date = workUnit.date {
                VStack(alignment: .leading) {
                    if workUnit.night {
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
                if let specialDayString = workUnit.specialDay,
                   let specialDay = SpecialDays(rawValue: specialDayString) {
                    HStack {
                        Text("\(specialDay.string)")
                        specialDay.image
                            .foregroundColor(Color.theme.gray)
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
                        Text("\(workUnit.secWork.toTimeString())")
                        if workUnit.specialDay == nil { Text("\(workUnit.secPause.toTimeString())") }
                    }
                    VStack {
                        ImageStore.hammer.image
                        if workUnit.specialDay == nil { ImageStore.pauseCircle.image }
                    }
                    .foregroundColor(Color.theme.gray)
                }
                .frame(width: Config.screenWidth * 0.28, alignment: .trailing)
            }
        }
        .font(.headline)
    }
}
