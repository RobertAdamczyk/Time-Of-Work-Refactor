//
//  MainView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @StateObject var coreDataManager = CoreDataManager()
    @StateObject var homeViewModel = HomeViewModel()

    init() {
        /// Orange title in navigations view
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
    }

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                Color.theme.background
                VStack {
                    if viewModel.view == .home {
                        HomeView()
                            .environmentObject(settingsViewModel)
                    }
                    if viewModel.view == .history {
                        HistoryView()
                    }
                }
                ToolbarView()
            }
            .zIndex(0)
            .blur(radius: viewModel.showPickerType != nil ? 10 : 0)
            if let pickerType = viewModel.showPickerType {
                PickerView(type: pickerType, date: $homeViewModel.lastDate,
                           pause: $homeViewModel.pause, onCloseAction: {
                    viewModel.showPicker(pickerType: nil)
                })
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
        }
        .environmentObject(viewModel)
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
            case .settings:
                MainSettingView()
                    .environmentObject(settingsViewModel)
            }
        }
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
