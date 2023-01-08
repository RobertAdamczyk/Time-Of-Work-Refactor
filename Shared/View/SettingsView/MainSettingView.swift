//
//  SettingsView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI
import ActivityKit

struct MainSettingView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    var body: some View {
        Form {
            Section(header: Text("General")) {
                NavigationLink(destination: TimeSettingView()) {
                    Text("Time")
                }
                NavigationLink(destination: LockScreenView()) {
                    Text("Lock Screen")
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
                        homeViewModel.updateLiveWork()
                    }
            }
            if viewModel.defaultPauseSetting {
                PausePickerView(pause: $viewModel.defaultPauseInSecSetting)
                    .onChange(of: viewModel.defaultPauseInSecSetting) { newValue in
                        homeViewModel.pauseTimeInSec = newValue
                        homeViewModel.updateLiveWork()
                    }
            }

        }
        .navigationBarTitle("Time", displayMode: .inline)
    }
}

struct LockScreenView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    let renew = "In case 'Live work' has been hidden by the user, it can be reenabled for current work."
    var body: some View {
        Form {
            Section(header: Text("General")) {
                Toggle("Lock screen", isOn: $viewModel.liveActivitiesPermission)
            }
            Section(footer: Text("\(renew)")) {
                Button {
                    homeViewModel.liveWorkViewModel.startLiveWork(for: .work,
                                                                  date: homeViewModel.lastDateForWork,
                                                                  startWorkDate: homeViewModel.lastDateForWork,
                                                                  pauseInSec: homeViewModel.pauseTimeInSec,
                                                                  workInSec: homeViewModel.currentWorkTimeInSec)
                } label: {
                    Text("Renew live work")
                        .foregroundColor(Color.theme.text)
                }
                .disabled(!homeViewModel.working) // if not working we dont want live activities
            }
            Section(header: Text("Additional")) {
                Toggle("Pause button", isOn: $viewModel.liveActivitiesPauseButton)
                Toggle("End work button", isOn: $viewModel.liveActivitiesEndWorkButton)
            }
        }
        .navigationBarTitle("Lock Screen", displayMode: .inline)
    }
}
