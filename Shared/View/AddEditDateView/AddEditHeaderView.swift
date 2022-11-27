//
//  AddEditHeaderView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

struct AddEditHeaderView: View {
    var deleteAction: (() -> Void)?
    var value: Dates?
    var body: some View {
        HStack {
            Text(value != nil ? "Edit Date" : "New Date")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
            Spacer()
            if value != nil {
                Button {
                    deleteAction?()
                } label: {
                    Image.store.trash
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal, 5)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(10)
        .backgroundWithBottom
    }
}
