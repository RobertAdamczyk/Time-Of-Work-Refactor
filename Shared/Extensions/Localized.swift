//
//  Localized.swift
//  Time Of Work
//
//  Created by Robert Adamczyk on 08.01.23.
//

import Foundation

public func localized(string key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
