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
                viewModel.changeShowComponent(newValue: .timeInPicker)
            } label: {
                HStack {
                    Text("Start").bold()
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(viewModel.new.timeIn, style: .time)").bold()
                        .foregroundColor(Color("Orange"))
                }
                .padding()
                .roundedBackgroundWithBorder
            }
            Spacer().frame(width: 20)
            Button {
                viewModel.changeShowComponent(newValue: .timeOutPicker)
            } label: {
                HStack {
                    Text("End").bold()
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(viewModel.new.timeOut, style: .time)").bold()
                        .foregroundColor(Color("Orange"))
                }
                .padding()
                .roundedBackgroundWithBorder
            }
        }
    }
}
