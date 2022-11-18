//
//  HoursPickerView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.03.21.
//

import SwiftUI

struct HoursPickerView: View {
    @Binding var value: Int
    var body: some View {
        VStack {
            Picker("", selection: $value) {
                ForEach(0..<11, id: \.self) { index in
                    Text("\(index)")
                }
            }
        }
        .backgroundWithBorder
    }
}
