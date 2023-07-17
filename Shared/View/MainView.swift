//
//  MainView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var homeViewModel: HomeViewModel
    @StateObject var historyViewModel: HistoryViewModel
    #if DEBUG
    @StateObject var debugViewModel = DebugMenuViewModel()
    #endif

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
        self._homeViewModel = .init(wrappedValue: .init(coordinator: coordinator))
        self._historyViewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }

    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment: .bottom) {
                    Color.theme.background

                    switch viewModel.view {
                    case .home: HomeView()
                    case .history: HistoryView()
                    }
                    ToolbarView()
                }
                .zIndex(0)
                .blur(radius: viewModel.showMenu ? 10 : 0)
                MenuView()
                    .offset(x: viewModel.showMenu ? 0 : -Config.screenWidth)
                    .environmentObject(settingsViewModel)
                #if DEBUG
                DebugMenuView()
                    .onShake {
                        debugViewModel.showMenu()
                    }
                    .opacity(debugViewModel.showDebugMenu ? 1 : 0)
                    .environmentObject(debugViewModel)
                #endif
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onOpenURL(perform: homeViewModel.handleDeeplink)
        .accentColor(Color.theme.accent)
        .environmentObject(viewModel)
        .environmentObject(settingsViewModel)
        .environmentObject(homeViewModel)
        .environmentObject(historyViewModel)
        .ignoresSafeArea(.all)
    }
}
