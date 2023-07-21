//
//  LiveWorkViewModel.swift
//  Time Of Work
//
//  Created by Robert Adamczyk on 07.01.23.
//

import SwiftUI
import ActivityKit

final class LiveActivitiesService {

    /// DeepLinks to handle user clicks in live activities
    enum DeepLink: String {
        case pauseButton = "liveActivities://pause.button"
        case endWorkButton = "liveActivities://end.work.button"
    }

    enum Context: Codable, Hashable {
        case work
        case pause
    }

    // MARK: Private properties

    /// Properties to store user defaults
    @AppStorage(Storable.liveActivitiesPauseButton.key) private var liveActivitiesPauseButton: Bool = true
    @AppStorage(Storable.liveActivitiesEndWorkButton.key) private var liveActivitiesEndWorkButton: Bool = true

    // MARK: Public functions
    public func startLiveWork(for context: Context, date: Date,
                              startWorkDate: Date, pauseInSec: Int, workInSec: Int) {
        if #available(iOS 16.1, *) {
            guard Activity<LiveWorkAttributes>.activities.count == 0 else { return }
            let dateForTimer = date.advanced(by: TimeInterval(pauseInSec))
            let activityAttribute = LiveWorkAttributes(liveActivitiesPauseButton: liveActivitiesPauseButton,
                                                       liveActivitiesEndWorkButton: liveActivitiesEndWorkButton)
            let initialContentState = LiveWorkAttributes.ContentState(context: context,
                                                                      dateForTimer: dateForTimer,
                                                                      startWorkDate: startWorkDate,
                                                                      pauseInSec: pauseInSec,
                                                                      workInSec: workInSec)
            do {
                let activity = try Activity<LiveWorkAttributes>.request(attributes: activityAttribute,
                                                                        contentState: initialContentState)
                #if DEBUG
                print("Activity added: \(activity.id)")
                #endif
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    public func updateLiveWork(for context: Context, date: Date,
                               startWorkDate: Date, pauseInSec: Int, workInSec: Int) {
        let dateForTimer: Date
        switch context {
        case .work:
            dateForTimer = date.advanced(by: TimeInterval(pauseInSec))
        case .pause:
            dateForTimer = date.advanced(by: TimeInterval(-pauseInSec))
        }
        let updatedContentState = LiveWorkAttributes.ContentState(context: context,
                                                                  dateForTimer: dateForTimer,
                                                                  startWorkDate: startWorkDate,
                                                                  pauseInSec: pauseInSec,
                                                                  workInSec: workInSec)
        Task {
            for activity in Activity<LiveWorkAttributes>.activities {
                await activity.update(using: updatedContentState)
            }
        }
    }

    public func removeLiveWork() {
        Task {
            for activity in Activity<LiveWorkAttributes>.activities {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
}
