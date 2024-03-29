//
//  SettingsViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {

    // MARK: Published variables
    @AppStorage(Storable.hoursDaySetting.key) var hoursDaySetting: Double = 8
    @AppStorage(Storable.defaultPauseSetting.key) var defaultPauseSetting: Bool = false
    @AppStorage(Storable.defaultPauseInSecSetting.key) var defaultPauseInSecSetting: Int = 0

    /// Live activities properties
    @AppStorage(Storable.liveActivitiesPermission.key) var liveActivitiesPermission: Bool = true
    @AppStorage(Storable.liveActivitiesPauseButton.key) var liveActivitiesPauseButton: Bool = true
    @AppStorage(Storable.liveActivitiesEndWorkButton.key) var liveActivitiesEndWorkButton: Bool = true

    private let coordinator: Coordinator

    @Dependency private var dependencies: Dependencies

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func onTimeSettingsTapped() {
        coordinator.push(.settings(.timeSettings(self)))
    }

    func onLockScreenSettingsTapped() {
        coordinator.push(.settings(.lockScreenSettings(self)))
    }

    func onChangeDefaultPause(pauseInSec: Int) {
        self.defaultPauseInSecSetting = pauseInSec
    }

    func onChangeLiveActivitiesPermission(newValue: Bool) {
        if !newValue {
            dependencies.liveActivitiesService.removeLiveWork()
        }
    }

    func onChangeToggleDefaultPause(newValue: Bool) {
        self.defaultPauseSetting = newValue
    }

    func onLiveActivitiesUpdateTapped() {
        dependencies.liveActivitiesService.delegate?.startLiveActivities()
    }
}
