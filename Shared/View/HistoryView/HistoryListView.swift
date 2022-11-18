//
//  HistoryListView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var viewModel: HistoryViewModel
    var result: FetchedResults<Dates>
    var body: some View {

        ForEach(viewModel.weeksAndYears, id: \.id) { item in
            VStack {
                HStack {
                    Text("\(item.weekOfYear)/\(String(item.yearForWeekOfYear))").bold()
                        .font(.title)
                        .foregroundColor(Color.theme.gray)
                    Spacer()
                }
                VStack(spacing: 0) {
                    Button {
                        withAnimation {
                            viewModel.weeksAndYears[viewModel.weeksAndYears.firstIndex(of: item)!].showWeek.toggle()
                            viewModel.selectedDate = nil
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("\(item.beginOfWeek, style: .date) -").bold()
                            Text("\(item.endOfWeek, style: .date)").bold()
                            Spacer()
                        }
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: false)
                        .foregroundColor(Color.theme.accent)
                        .padding(.vertical, 10)
                    }
                    if item.showWeek {
                        VStack(spacing: 0) {
                            ForEach(result, id: \.self) { date in
                                if viewModel.dateIsEqualWeekAndYear(date: date.date, value: item) {
                                    Divider()
                                    HistoryRow(value: date)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            withAnimation {
                                                viewModel.selectedDate = viewModel.selectedDate == date ? nil : date
                                            }
                                        }
                                        .overlay(
                                            MenuBarView(date: date) // menu delete edit row of date
                                        )
                                }
                            }
                        }
                    }
                    Divider()
                    ForEach(viewModel.sumOfWeeks) { index in
                        if index.week.weekOfYear == item.weekOfYear &&
                           index.week.yearForWeekOfYear == item.yearForWeekOfYear {
                            HistoryTotalView(item: index)
                        }
                    }
                }
                .roundedBackgroundWithBorder
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
