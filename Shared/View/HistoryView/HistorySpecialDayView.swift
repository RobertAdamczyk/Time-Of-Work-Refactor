//
//  HistorySpecialDayView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 30.03.21.
//

import SwiftUI

struct HistorySpecialDayView: View {
    var value: String
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("\(value)")
                if let specialDay = SpecialDays.specialDay(for: value) {
                    specialDay.image
                        .foregroundColor(Color.theme.gray)
                }
            }
        }
    }
}
