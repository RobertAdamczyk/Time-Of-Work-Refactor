//
//  Config.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 01.12.22.
//

import SwiftUI

struct CellConfig {
    static let padding: CGFloat = 20
    static let height: CGFloat = UIScreen.main.bounds.height * 0.5
    static let offsetBottomCell: CGFloat = UIScreen.main.bounds.height * 0.7
    static let offsetTopCell: CGFloat = UIScreen.main.bounds.height * 0.80
}

struct Config {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let menuWidth = screenWidth * 0.4
    /// After 24 hours auto-checkout
    static let automaticCheckoutAfterSec: Double = 3600 * 24
}
