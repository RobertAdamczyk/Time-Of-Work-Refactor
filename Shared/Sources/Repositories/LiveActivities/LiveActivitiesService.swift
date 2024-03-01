//
//  LiveWorkViewModel.swift
//  Time Of Work
//
//  Created by Robert Adamczyk on 07.01.23.
//

import SwiftUI
import ActivityKit

protocol LiveActivitiesDelegate: AnyObject {

    func startLiveActivities()
}

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

    weak var delegate: LiveActivitiesDelegate?

    // MARK: Private properties

    /// Properties to store user defaults
    @AppStorage(Storable.liveActivitiesPauseButton.key) private var liveActivitiesPauseButton: Bool = true
    @AppStorage(Storable.liveActivitiesEndWorkButton.key) private var liveActivitiesEndWorkButton: Bool = true
    @AppStorage(Storable.liveActivitiesPermission.key) private var liveActivitiesPermission: Bool = true

    // MARK: Public functions
    public func startLiveWork(for context: Context, date: Date,
                              startWorkDate: Date, pauseInSec: Int, workInSec: Int) {
        guard liveActivitiesPermission else { return }
        guard Activity<LiveWorkAttributes>.activities.count == 0 else { return }
        let dateForTimer = date.advanced(by: TimeInterval(pauseInSec))
        let activityAttribute = LiveWorkAttributes(liveActivitiesPauseButton: liveActivitiesPauseButton,
                                                   liveActivitiesEndWorkButton: liveActivitiesEndWorkButton,
                                                   isDarkMode: UIScreen.main.traitCollection.userInterfaceStyle == .dark)
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
