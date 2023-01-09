//
//  FirebaseValuesEvents.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.01.23.
//

extension Analytics {
    enum Event: String {
        case click
        case swipe
    }

    enum Value: String {
        case startWork = "start_work"
        case endWork = "end_work"
    }

    enum Parameter: String {
        case screenName = "screen_name"
        case action
    }

    enum Screen: String {
        case homeScreen = "home_screen"
        case history = "history"
    }
}
