//
//  HistoryHeader.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 04.03.21.
//

import SwiftUI

struct HistoryHeader: View {
    var body: some View {
        HStack {
            HStack {
                Text("History")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)
                    .padding(.leading, 5)
                Spacer()
            }
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(10)
        .backgroundWithBorder
        .padding(.horizontal, -1)
        .padding(.top, -1)
    }
}
