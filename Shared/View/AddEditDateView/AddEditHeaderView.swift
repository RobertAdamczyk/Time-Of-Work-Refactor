//
//  AddEditHeaderView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

struct AddEditHeaderView: View {
    var value: String
    var body: some View {
        HStack {
            Text("\(value)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
                .padding(.leading, 5)
            Spacer()
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(10)
        .backgroundWithBottom
    }
}
