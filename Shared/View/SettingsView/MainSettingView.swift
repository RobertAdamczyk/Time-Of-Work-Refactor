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
            Section(header: Text(localized(string: "settings_section_general"))) {
                NavigationLink(destination: TimeSettingView()) {
                    Text(localized(string: "generic_time"))
                }
                NavigationLink(destination: LockScreenView()) {
                    Text(localized(string: "settings_lock_screen"))
                }
            }
        }
        .navigationBarTitle(localized(string: "generic_settings"), displayMode: .large)
    }
}

struct TimeSettingView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    var body: some View {
        Form {
            Section(header: Text(localized(string: "settings_your_goal"))) {
                HStack {
                    Text(localized(string: "settings_working_hours_a_day"))
                    Spacer()
                    Text("\(Int(viewModel.hoursDaySetting))")
                        .foregroundColor(Color.theme.accent)
                }
                Slider(value: $viewModel.hoursDaySetting, in: 0...12, step: 1)
            }
            Section(footer: Text(localized(string: "settings_pause_footer"))) {
                Toggle(localized(string: "settings_default_pause"), isOn: $viewModel.defaultPauseSetting.animation())
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
    var body: some View {
        Form {
            Section(header: Text(localized(string: "settings_section_general"))) {
                Toggle(localized(string: "settings_lock_screen"), isOn: $viewModel.liveActivitiesPermission)
            }
            Section(footer: Text(localized(string: "settings_live_activities_renew_description"))) {
                Button {
                    homeViewModel.liveWorkViewModel.startLiveWork(for: .work,
                                                                  date: homeViewModel.lastDateForWork,
                                                                  startWorkDate: homeViewModel.lastDateForWork,
                                                                  pauseInSec: homeViewModel.pauseTimeInSec,
                                                                  workInSec: homeViewModel.currentWorkTimeInSec)
                } label: {
                    Text(localized(string: "settings_live_activities_renew"))
                        .foregroundColor(Color.theme.text)
                }
                .disabled(!homeViewModel.working) // if not working we dont want live activities
            }
            Section(header: Text(localized(string: "settings_section_additional"))) {
                Toggle(localized(string: "settings_pause_button"), isOn: $viewModel.liveActivitiesPauseButton)
                Toggle(localized(string: "settings_end_work_button"), isOn: $viewModel.liveActivitiesEndWorkButton)
            }
        }
        .navigationBarTitle(localized(string: "settings_lock_screen"), displayMode: .inline)
    }
}
