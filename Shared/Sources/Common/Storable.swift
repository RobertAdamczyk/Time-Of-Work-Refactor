//
//  Storage.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.12.22.
//

enum Storable {
    case working
    case isPauseOn
    case pauseTimeInSec
    case lastDateForWork
    case lastDateForPause

    case hoursDaySetting
    case defaultPauseSetting
    case defaultPauseInSecSetting

    case liveActivitiesPermission
    case liveActivitiesPauseButton
    case liveActivitiesEndWorkButton

    case firebaseAnalytics

    case currentCountReview
    case lastCountedReview

    var key: String {
        switch self {
        case .working:
            return "working"
        case .pauseTimeInSec:
            return "pauseTimeInSec"
        case .lastDateForWork:
            return "lastDateForWork"
        case .isPauseOn:
            return "isPauseOn"
        case .lastDateForPause:
            return "lastDateForPause"
        case .hoursDaySetting:
            return "hoursDaySetting"
        case .defaultPauseSetting:
            return "defaultPauseSetting"
        case .defaultPauseInSecSetting:
            return "defaultPauseInSecSetting"
        case .liveActivitiesPermission:
            return "liveActivitiesPermission"
        case .liveActivitiesPauseButton:
            return "liveActivitiesPauseButton"
        case .liveActivitiesEndWorkButton:
            return "liveActivitiesEndWorkButton"
        case .firebaseAnalytics:
            return "firebaseAnalytics"
        case .currentCountReview:
            return "currentCountReview"
        case .lastCountedReview:
            return "lastCountedReview"
        }
    }
}
