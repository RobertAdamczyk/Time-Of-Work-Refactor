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
    @EnvironmentObject var coreDataManager: CoreDataManager
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var historyViewModel = HistoryViewModel()
    #if DEBUG
    @StateObject var debugViewModel = DebugMenuViewModel()
    #endif

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }

    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment: .bottom) {
                    Color.theme.background

                    switch viewModel.view {
                    case .home: HomeView().onAppear { Analytics.logFirebaseScreenEvent(.homeScreen) }
                    case .history: HistoryView().onAppear { Analytics.logFirebaseScreenEvent(.history) }
                    }
                    ToolbarView()
                }
                .zIndex(0)
                .blur(radius: viewModel.showPickerType != nil || viewModel.showMenu ? 10 : 0)
                if let pickerType = viewModel.showPickerType {
                    PickerView(type: pickerType, date: $homeViewModel.lastDateForWork,
                               pause: $homeViewModel.pauseTimeInSec, onCloseAction: {
                        homeViewModel.refreshWorkTime()
                        homeViewModel.updateLiveWork()
                        viewModel.showPicker(pickerType: nil)
                    })
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                }
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
        .onOpenURL { url in
            if let deepLink = LiveWorkViewModel.DeepLink(rawValue: url.absoluteString) {
                switch deepLink {
                case .pauseButton:
                    Analytics.logFirebaseClickEvent(.pauseLiveWork)
                    homeViewModel.onSwipePauseButton()
                case .endWorkButton:
                    Analytics.logFirebaseClickEvent(.endLiveWork)
                    homeViewModel.onSwipeWorkButton { newRecord in
                        coreDataManager.addDate(for: newRecord)
                    }
                }
            }
        }
        .accentColor(Color.theme.accent)
        .environmentObject(viewModel)
        .environmentObject(settingsViewModel)
        .environmentObject(coreDataManager)
        .environmentObject(homeViewModel)
        .environmentObject(historyViewModel)
        .ignoresSafeArea(.all)
    }
}
