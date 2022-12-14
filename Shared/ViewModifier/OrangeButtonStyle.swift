//
//  OrangeButtonStyle.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import Foundation
import SwiftUI

struct OrangeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color("Orange")).shadow(color: .black, radius: configuration.isPressed ? 0 : 1, x: configuration.isPressed ? 0 : 1, y: configuration.isPressed ? 0 : 1))
            .opacity(configuration.isPressed ? 0.7 : 1)
            .offset(x: configuration.isPressed ? 1 : 0, y: configuration.isPressed ? 1 : 0)
    }
}
