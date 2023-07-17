//
//  HistoryView2.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.11.22.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var viewModel: HistoryViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(Array(viewModel.workUnits.enumerated()), id: \.element) { index, workUnit in
                        HistoryListRowView(previousWorkUnit: index - 1 >= 0 ? viewModel.workUnits[index-1] : nil,
                                           workUnit: workUnit,
                                           nextWorkUnit: index + 1 < viewModel.workUnits.count ? viewModel.workUnits[index+1] : nil)
                        .padding(.horizontal, 16)
                    }
                }
                Spacer().frame(height: 120)
                // TODO: Value = 120 ? Maybe property ?
                // We need spacer, because last value is in the back of toolbar bottom
            }
            .navigationTitle(localized(string: "generic_history"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.onSectionButtonTapped()
                    } label: {
                        ImageStore.sliderHorizontal.image
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        mainViewModel.showMenuAction()
                    } label: {
                        ImageStore.menu.image
                            .font(.title3)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: viewModel.onViewAppear)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
