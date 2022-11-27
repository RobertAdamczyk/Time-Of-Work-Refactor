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
                        VStack(spacing: 10) {
                            if let section = date.section {
                                HStack {
                                    Text(section)
                                        .font(.caption)
                                        .fontWeight(.semibold)
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
                            if viewModel.showTotalView(in: coreDataManager.dates, for: date) {
                                ForEach(viewModel.total, id: \.self) { total in
                                    if total.lastDate == date {
                                        TotalView(date: date, total: total)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 17)
                    }
                }
                Spacer().frame(height: 120)
                // TODO: Value = 120 ? Maybe property ?
                // We need spacer, because last value is in the back of toolbar bottom
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

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
