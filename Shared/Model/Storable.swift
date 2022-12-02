//
//  Storage.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.12.22.
//

enum Storable {
    case working
    case pause
    case lastDate

    var key: String {
        switch self {
        case .working:
            return "working"
        case .pause:
            return "pause"
        case .lastDate:
            return "lastDate"
        }
    }
}
