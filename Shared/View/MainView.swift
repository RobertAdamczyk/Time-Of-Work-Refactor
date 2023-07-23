//
//  MainView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    @StateObject var homeViewModel: HomeViewModel
    @StateObject var historyViewModel: HistoryViewModel

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
        self._homeViewModel = .init(wrappedValue: .init(coordinator: coordinator))
        self._historyViewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }

    var body: some View {
        ZStack {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                switch viewModel.view {
                case .home: HomeView()
                case .history: HistoryView()
                }
                VStack {
                    Spacer()
                    ToolbarView()
                }
                .ignoresSafeArea()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.onMenuTapped()
                } label: {
                    ImageStore.menu.image
                        .font(.title3)
                }
            }
        }
        .onOpenURL(perform: homeViewModel.handleDeeplink)
        .environmentObject(viewModel)
        .environmentObject(homeViewModel)
        .environmentObject(historyViewModel)
    }
}
