//
//  SheetViewsEnum.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 16.03.21.
//

import Foundation

enum SheetView: Identifiable {
    case addDate
    case editDate
    case settings
    
    var id: Int {
        hashValue
    }
}
