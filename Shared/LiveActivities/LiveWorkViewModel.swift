//
//  LiveWorkViewModel.swift
//  Time Of Work
//
//  Created by Robert Adamczyk on 07.01.23.
//

import SwiftUI
import ActivityKit

class LiveWorkViewModel {
    enum DeepLink: String {
        case startPauseButton = "liveActivities://start.pause.button"
        case endWorkButton = "liveActivities://end.work.button"
    }
    enum Context: Codable, Hashable {
        case work
        case pause
    }
    public func startLiveWork(for context: LiveWorkViewModel.Context, date: Date,
                              startWorkDate: Date, pauseInSec: Int, workInSec: Int) {
        if #available(iOS 16.1, *) {
            let dateForTimer = date.advanced(by: TimeInterval(pauseInSec))
            let activityAttribute = LiveWorkAttributes()
            let initialContentState = LiveWorkAttributes.ContentState(context: context,
                                                                      dateForTimer: dateForTimer,
                                                                      startWorkDate: startWorkDate,
                                                                      pauseInSec: pauseInSec,
                                                                      workInSec: workInSec)
            do {
                let activity = try Activity<LiveWorkAttributes>.request(attributes: activityAttribute,
                                                                        contentState: initialContentState)
                print("Activity added: \(activity.id)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    public func updateLiveWork(for context: LiveWorkViewModel.Context, date: Date,
                               startWorkDate: Date, pauseInSec: Int, workInSec: Int) {
        if #available(iOS 16.1, *) {
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
    }

    public func removeLiveWork() {
        if #available(iOS 16.1, *) {
            Task {
                for activity in Activity<LiveWorkAttributes>.activities {
                    await activity.end(dismissalPolicy: .immediate)
                }
            }
        }
    }
}
