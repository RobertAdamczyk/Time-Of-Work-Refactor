//
//  WorkingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.11.22.
//

import SwiftUI

struct WorkingCell: View, HomeCellProvider {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager
    var body: some View {
        ZStack {
            cellShape
            VStack {
                NowRow()
                ButtonsRow()
                    .padding(.top, 20)
                Spacer()
                SwipeButton(type: .end, disabled: viewModel.currentCell == .idle, action: {
                    viewModel.onSwipeButton { newRecord in
                        coreDataManager.addDate(for: newRecord)
                    }
                })
                .padding(.bottom, 30)
            }
        }
        .environmentObject(viewModel)
    }
}

struct WorkingCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkingCell()
    }
}
