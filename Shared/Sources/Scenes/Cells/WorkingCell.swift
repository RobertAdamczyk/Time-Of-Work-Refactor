//
//  WorkingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.11.22.
//

import SwiftUI

struct WorkingCell: View, HomeCellProvider {
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            makeCellShape(colorScheme: colorScheme)
            VStack {
                NowRow()
                Spacer()
                if !viewModel.isPauseOn {
                    SwipeButton(type: .start, model: .startPause, disabled: false, action: viewModel.onSwipePauseButton)
                } else {
                    SwipeButton(type: .end, model: .endPause, disabled: false, action: viewModel.onSwipePauseButton)
                }
                Spacer()
                SwipeButton(type: .end, model: .endWork, disabled: viewModel.currentCell == .idle,
                            action: viewModel.onSwipeWorkButton)
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
