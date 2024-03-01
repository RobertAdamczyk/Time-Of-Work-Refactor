//
//  Colors.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 18.11.22.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let background = Color("BackgroundColor")
    let widgetBackgroundLight = Color("WidgetBackground")
    let widgetBackgroundDark = Color("WidgetBackgroundDark")
    let border = Color("BorderColor")
    let black = Color("Black")
    let accent = Color("Orange")
    let buttonText = Color("White")
    let red = Color("Red")
    let green = Color.green
    let gray = Color.gray
    let shadow = Color("Shadow")
    let cell = Color("WhiteBlack")
    let text = Color("BlackWhite")
}
