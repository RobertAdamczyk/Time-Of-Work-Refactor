//
//  HomeView2.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 27.11.22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ZStack {
                ForEach(HomeCell.allCases, id: \.self) { cell in
                    cell
                        .frame(height: CellConfig.height)
                        .padding(.horizontal, CellConfig.padding)
                        .stackedCells(for: cell, currentCell: viewModel.currentCell)
                }
            }
            .toolbar {
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension View {
    func stackedCells(for cell: HomeCell, currentCell: HomeCell) -> some View {
        switch cell {
        case .idle:
            if currentCell == .working {
                return self
                    .offset(x: 0, y: -CellConfig.offsetTopCell)
                    .rotation3DEffect(.degrees(15), axis: (x: 1, y: 0, z: 0))
                    .scaleEffect(0.8)
            } else {
                return self
                    .offset(x: 0, y: 0)
                    .rotation3DEffect(.degrees(0), axis: (x: 1, y: 0, z: 0))
                    .scaleEffect(1)
            }
        case .working:
            if currentCell == .working {
                return self
                    .offset(x: 0, y: 0)
                    .rotation3DEffect(.degrees(0), axis: (x: 1, y: 0, z: 0))
                    .scaleEffect(1)
            } else {
                return self
                    .offset(x: 0, y: CellConfig.offsetBottomCell)
                    .rotation3DEffect(.degrees(0), axis: (x: 1, y: 0, z: 0))
                    .scaleEffect(0.9)
            }
        }
    }
}
