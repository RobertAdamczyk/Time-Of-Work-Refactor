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
    @EnvironmentObject var viewModel: HistoryViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.state == .idle {
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
                        } // foreach
                    } // lazyvstack
                } // if loading
                Spacer().frame(height: 120)
                // TODO: Value = 120 ? Maybe property ?
                // We need spacer, because last value is in the back of toolbar bottom
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.onSectionButtonTapped(dates: coreDataManager.dates)
                    } label: {
                        Image.store.sliderHorizontal
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        mainViewModel.showMenuAction()
                    } label: {
                        Image.store.menu
                            .font(.title3)
                    }
                }
            }
        }
        .overlay( ZStack {
            if viewModel.state == .loading {
                ProgressView()
                    .scaleEffect(2)
            }
        })
        .onAppear {
            viewModel.onViewAppear(dates: coreDataManager.dates)
        }
        .onChange(of: coreDataManager.dates) { newValue in
            viewModel.onChangeDates(dates: newValue)
        }
        .environmentObject(viewModel)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
