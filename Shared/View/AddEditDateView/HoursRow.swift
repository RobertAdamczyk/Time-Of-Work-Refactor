//
//  HoursRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.03.21.
//

import SwiftUI

struct HoursRow: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    var body: some View {
        Button {
            viewModel.showPicker(pickerType: .special)
        } label: {
            HStack {
                Text("Hours").bold()
                    .foregroundColor(Color.theme.gray)
                Spacer()
                Text("\(viewModel.new.hoursSpecialDay)").bold()
                    .foregroundColor(Color.theme.accent)
            }
            .padding()
            .roundedBackgroundWithBorder
        }
    }
}
