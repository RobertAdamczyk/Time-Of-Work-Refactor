//
//  LiveWorkAttributes.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 26.12.22.
//

import ActivityKit
import SwiftUI

struct LiveWorkAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var context: LiveActivitiesService.Context
        var dateForTimer: Date
        var startWorkDate: Date
        var pauseInSec: Int
        var workInSec: Int
    }
    /// User defaults
    var liveActivitiesPauseButton: Bool
    var liveActivitiesEndWorkButton: Bool
    // Fixed non-changing properties about your activity go here!

    var isDarkMode: Bool

}
