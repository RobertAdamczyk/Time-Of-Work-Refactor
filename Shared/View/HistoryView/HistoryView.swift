//
//  HistoryView2.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.11.22.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager
    @StateObject var viewModel: HistoryViewModel = HistoryViewModel()

    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
    }
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(coreDataManager.dates, id: \.self) { date in
                        VStack(spacing: 5) {
                            if let section = date.section {
                                HStack {
                                    Text(section)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.theme.gray)
                                    Spacer()
                                }
                                .padding(.top, 10)
                            }
                            HistoryListRowView(value: date)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    mainViewModel.dateToEdit = date
                                    mainViewModel.activeSheet = .editDate
                                }
                            Divider()
                        }
                        .padding(.horizontal, 17)
                    }
                }
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.changeSectionType()
                        viewModel.createSection(dates: coreDataManager.dates)
                    } label: {
                        Image.store.listNumber
                            .font(.title3)
                    }
                }
            }
        }
        .accentColor(Color.theme.accent)
        .onAppear {
            viewModel.createSection(dates: coreDataManager.dates)
        }
        .onChange(of: coreDataManager.dates) { _ in
            viewModel.createSection(dates: coreDataManager.dates)
        }
        .environmentObject(viewModel)
    }
}

struct HistoryListRowView: View {
    let value: Dates
    var body: some View {
        HStack(spacing: 0) {
            if let timeIn = value.timeIn, let timeOut = value.timeOut, let date = value.date {
                VStack(alignment: .leading) {
                    if value.night {
                        Text("\(date.toString(format: .dayOnlyShort))-" +
                             "\(date.plusOneDay()!.toString(format: .dayOnlyShort))")
                        Text("\(date.toString(format: .dayOnlyNumber))-" +
                             "\(date.plusOneDay()!.toString(format: .shortDate))")
                    } else {
                        Text("\(date.toString(format: .dayOnly))")
                        Text("\(date.toString(format: .shortDate))")
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.28, alignment: .leading)
                Spacer()
                if let specialDay = value.specialDay {
                    HStack {
                        Text("\(specialDay)")
                        if let special = SpecialDays(rawValue: specialDay) {
                            special.image
                                .foregroundColor(Color.theme.gray)
                        }
                    }
                } else {
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("\(timeIn, style: .time)")
                            Image.store.arrowUpLeft
                                .foregroundColor(Color.theme.green)
                        }
                        HStack {
                            Text("\(timeOut, style: .time)")
                            Image.store.arrowUpRight
                                .foregroundColor(Color.theme.red)
                        }
                    }
                }
                Spacer()
                HStack {
                    VStack(alignment: .trailing) {
                        Text("\(value.secWork.toTimeString())")
                        if value.specialDay == nil { Text("\(value.secPause.toTimeString())") }
                    }
                    VStack {
                        Image.store.hammer
                        if value.specialDay == nil { Image.store.pauseCircle }
                    }
                    .foregroundColor(Color.theme.gray)
                }
                .frame(width: UIScreen.main.bounds.width * 0.28, alignment: .trailing)
            }
        }
        .font(.headline)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
