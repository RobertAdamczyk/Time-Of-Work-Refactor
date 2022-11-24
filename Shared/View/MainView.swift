//
//  MainView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    @ObservedObject var historyViewModel = HistoryViewModel()
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @StateObject var coreDataManager = CoreDataManager()
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.theme.background
            VStack {
                if viewModel.view == .home {
                    HomeView()
                        .environmentObject(homeViewModel)
                        .environmentObject(settingsViewModel)
                }
                if viewModel.view == .history {
                    HistoryView()
                        .environmentObject(historyViewModel)
                }
            }
            ToolbarView()
        }
        .environmentObject(viewModel)
        .sheet(item: $viewModel.activeSheet) { item in
            switch item {
            case .addDate:
                AddEditDateView(activeSheet: $viewModel.activeSheet, name: "New Date")
            case .editDate:
                AddEditDateView(activeSheet: $viewModel.activeSheet,
                                value: historyViewModel.selectedDate, name: "Edit Date")
            case .settings:
                MainSettingView()
                    .environmentObject(settingsViewModel)
            }
        }
        .environmentObject(coreDataManager)
        .ignoresSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
