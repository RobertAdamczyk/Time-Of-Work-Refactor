//
//  HistoryView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @EnvironmentObject var viewModel: HistoryViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                Spacer().frame(height: ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 70)
                HistoryListView()
                Spacer().frame(height: ((UIApplication.shared.windows.first?.safeAreaInsets.bottom) ?? 0) + 90)
            }
            HistoryHeader()
        }
        .onTapGesture {
            withAnimation {
                viewModel.selectedDate = nil
            }
        }
        .onAppear {
            viewModel.loadArrays(array: coreDataManager.dates)
        }
        .onReceive(viewModel.refreshHistory) { _ in
            viewModel.loadArrays(array: coreDataManager.dates)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
