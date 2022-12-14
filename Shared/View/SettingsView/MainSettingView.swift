//
//  SettingsView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

struct MainSettingView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    var body: some View {
        Form {
            Section(header: Text("Your personal time settings")) {
                NavigationLink(destination: TimeSettingView()) {
                    Text("Time")
                }
            }
        }
        .navigationBarTitle("Settings", displayMode: .large)
    }
}

struct TimeSettingView: View {
    let pauseFooter = "The default pause will save you time while" +
                      " using the application if you know how long your break is."
    @EnvironmentObject var viewModel: SettingsViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    var body: some View {
        Form {
            Section(header: Text("Your goal")) {
                HStack {
                    Text("Working hours a day")
                    Spacer()
                    Text("\(Int(viewModel.hoursDaySetting))")
                        .foregroundColor(Color.theme.accent)
                }
                Slider(value: $viewModel.hoursDaySetting, in: 0...12, step: 1)
            }
            Section(footer: Text(pauseFooter)) {
                Toggle("Default pause", isOn: $viewModel.defaultPauseSetting.animation())
                    .onChange(of: viewModel.defaultPauseSetting) { newValue in
                        homeViewModel.pauseTimeInSec = newValue ? viewModel.defaultPauseInSecSetting : 0
                    }
            }
            if viewModel.defaultPauseSetting {
                PausePickerView(pause: $viewModel.defaultPauseInSecSetting)
                    .onChange(of: viewModel.defaultPauseInSecSetting) { newValue in
                        homeViewModel.pauseTimeInSec = newValue
                    }
            }

        }
        .navigationBarTitle("Time", displayMode: .inline)
    }
}
