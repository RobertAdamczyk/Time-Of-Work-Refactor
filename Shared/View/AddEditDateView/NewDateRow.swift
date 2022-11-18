//
//  DateRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import SwiftUI

struct NewDateRow: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    var body: some View {
        Button {
                viewModel.changeShowComponent(newValue: .datePicker)
        } label: {
            HStack {
                Text("Date").bold()
                    .foregroundColor(.gray)
                Spacer()
                HStack {
                    if viewModel.new.night {
                        Text("\(viewModel.new.date.toString(format: .shortDate)) -").bold()
                        Text("\(viewModel.new.date.plusOneDay()!, style: .date)").bold()
                    } else {
                        Text("\(viewModel.new.date, style: .date)").bold()
                    }
                }
                .foregroundColor(Color("Orange"))
            }
            .padding()
            .roundedBackgroundWithBorder
        }
    }

}
