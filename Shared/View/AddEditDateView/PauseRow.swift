//
//  PauseRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 06.03.21.
//

import SwiftUI

struct PauseRow: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    var body: some View {
        Button {
            viewModel.showPicker(pickerType: .pause)
        } label: {
            HStack {
                Text("Pause").bold()
                    .foregroundColor(Color.theme.gray)
                Spacer()
                Text("\(viewModel.new.secPause.toTimeString())").bold()
                    .foregroundColor(Color.theme.accent)
            }
            .padding()
            .roundedBackgroundWithBorder
        }
    }
}
