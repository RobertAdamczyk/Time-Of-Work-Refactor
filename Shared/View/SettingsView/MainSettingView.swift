//
//  SettingsView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI
import ActivityKit

struct MainSettingView: View {

    @StateObject var viewModel: SettingsViewModel

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }

    var body: some View {
        Form {
            Section(header: Text(localized(string: "settings_section_general"))) {
                Button(action: viewModel.onTimeSettingsTapped) {
                    Text(localized(string: "generic_time"))
                }
                Button(action: viewModel.onLockScreenSettingsTapped) {
                    Text(localized(string: "settings_lock_screen"))
                }
            }
        }
        .navigationBarTitle(localized(string: "generic_settings"), displayMode: .large)
        .onAppear {
            Analytics.logFirebaseScreenEvent(.settings)
        }
        .environmentObject(viewModel)
    }
}

struct TimeSettingView: View {

    @ObservedObject var viewModel: SettingsViewModel

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
                    .onChange(of: viewModel.defaultPauseSetting, perform: viewModel.onChangeToggleDefaultPause)
            }
            if viewModel.defaultPauseSetting {
                PausePickerView(pause: $viewModel.defaultPauseInSecSetting)
                    .onChange(of: viewModel.defaultPauseInSecSetting, perform: viewModel.onChangeDefaultPause)
            }

        }
        .navigationBarTitle("Time", displayMode: .inline)
        .onAppear {
            Analytics.logFirebaseScreenEvent(.settingsTime)
        }
    }
}

struct LockScreenView: View {

    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        Form {
            if #available(iOS 16.1, *) {
                Section(header: Text(localized(string: "settings_section_general"))) {
                    Toggle(localized(string: "settings_lock_screen"), isOn: $viewModel.liveActivitiesPermission)
                }
                Section(footer: Text(localized(string: "settings_live_activities_renew_description"))) {
                    Button {
                        viewModel.onLiveActivitiesUpdateTapped()
                    } label: {
                        Text(localized(string: "settings_live_activities_renew"))
                            .foregroundColor(Color.theme.text)
                    }
                }
                Section(header: Text(localized(string: "settings_section_additional"))) {
                    Toggle(localized(string: "settings_pause_button"), isOn: $viewModel.liveActivitiesPauseButton)
                    Toggle(localized(string: "settings_end_work_button"), isOn: $viewModel.liveActivitiesEndWorkButton)
                }
            } else {
                Section(footer: Text(localized(string: "settings_update_live_activities"))) {
                    EmptyView()
                }
            }
        }
        .navigationBarTitle(localized(string: "settings_lock_screen"), displayMode: .inline)
        .onAppear {
            Analytics.logFirebaseScreenEvent(.settingsLiveWork)
        }
    }
}
