//
//  Images.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 18.11.22.
//

import SwiftUI

extension Image {
    static let store = ImageStore()
}

struct ImageStore {
    let checkmark = Image(systemName: "checkmark")
    let person = Image(systemName: "person.fill")
    let info = Image(systemName: "info")
    let chevronRight = Image(systemName: "chevron.right")
    let chevronBackward = Image(systemName: "chevron.backward")
    let arrowUpLeft = Image(systemName: "arrowshape.turn.up.left.fill")
    let arrowUpRight = Image(systemName: "arrowshape.turn.up.right.fill")
    let hammer = Image(systemName: "hammer.fill")
    let pauseCircle = Image(systemName: "pause.circle")
    let caseFill = Image(systemName: "case.fill")
    let flag = Image(systemName: "flag.fill")
    let bandage = Image(systemName: "bandage.fill")
    let menu = Image(systemName: "line.3.horizontal")
    let gearshape = Image(systemName: "gearshape.fill")
    let calendar = Image(systemName: "calendar")
    let plus = Image(systemName: "plus.circle.fill")
    let square2x2 = Image(systemName: "square.grid.2x2")
    let sliderHorizontal = Image(systemName: "slider.horizontal.3")
    let close = Image(systemName: "xmark")
    let envelope = Image(systemName: "envelope.fill")
}
