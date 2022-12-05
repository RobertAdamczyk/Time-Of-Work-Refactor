//
//  IdleView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.11.22.
//

import SwiftUI

struct IdleCell: View, HomeCellProvider {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager
    var body: some View {
        ZStack {
            cellShape
            VStack(spacing: 20) {
                LastWorkView()
                ChartView()
                SwipeButton(type: .start, model: .startWork, disabled: viewModel.currentCell == .working, action: {
                    viewModel.onSwipeWorkButton()
                })
            }
            .padding(.vertical, 40)
        }
        .environmentObject(viewModel)
    }
}

struct IdleCell_Previews: PreviewProvider {
    static var previews: some View {
        IdleCell()
    }
}
