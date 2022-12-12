//
//  MainView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var coreDataManager = CoreDataManager()
    @StateObject var homeViewModel = HomeViewModel()

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
                .blur(radius: viewModel.showPickerType != nil || viewModel.showMenu ? 10 : 0)
                if let pickerType = viewModel.showPickerType {
                    PickerView(type: pickerType, date: $homeViewModel.lastDateForWork,
                               pause: $homeViewModel.pauseTimeInSec, onCloseAction: {
                        homeViewModel.refreshWorkTime()
                        viewModel.showPicker(pickerType: nil)
                    })
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                }
                MenuView()
                    .offset(x: viewModel.showMenu ? 0 : -Config.screenWidth)
                    .environmentObject(settingsViewModel)
            }
            .ignoresSafeArea()
        }
        .sheet(item: $viewModel.activeSheet) { item in
            switch item {
            case .addDate:
                AddEditDateView(activeSheet: $viewModel.activeSheet)
            case .editDate:
                AddEditDateView(activeSheet: $viewModel.activeSheet,
                                value: viewModel.dateToEdit, deleteAction: {
                    viewModel.activeSheet = nil
                    coreDataManager.removeDate(date: viewModel.dateToEdit)
                })
            }
        }
        .accentColor(Color.theme.accent)
        .environmentObject(viewModel)
        .environmentObject(settingsViewModel)
        .environmentObject(coreDataManager)
        .environmentObject(homeViewModel)
        .ignoresSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
