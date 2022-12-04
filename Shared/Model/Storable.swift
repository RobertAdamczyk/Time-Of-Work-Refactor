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
        }
    }
}
