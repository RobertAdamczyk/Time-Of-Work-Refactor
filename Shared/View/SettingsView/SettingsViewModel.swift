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
}
