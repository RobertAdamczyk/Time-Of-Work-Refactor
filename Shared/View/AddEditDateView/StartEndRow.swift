//
//  StartEndView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import SwiftUI

struct StartEndRow: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    var body: some View {
        HStack {
            Button {
                viewModel.showPicker(pickerType: .timeIn)
            } label: {
                HStack {
                    Text("Start").bold()
                        .foregroundColor(Color.theme.gray)
                    Spacer()
                    Text("\(viewModel.new.timeIn, style: .time)").bold()
                        .foregroundColor(Color.theme.accent)
                }
                .padding()
                .roundedBackgroundWithBorder
            }
            Spacer().frame(width: 20)
            Button {
                viewModel.showPicker(pickerType: .timeOut)
            } label: {
                HStack {
                    Text("End").bold()
                        .foregroundColor(Color.theme.gray)
                    Spacer()
                    Text("\(viewModel.new.timeOut, style: .time)").bold()
                        .foregroundColor(Color.theme.accent)
                }
                .padding()
                .roundedBackgroundWithBorder
            }
        }
    }
}
