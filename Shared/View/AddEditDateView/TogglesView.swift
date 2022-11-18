//
//  TogglesView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 28.03.21.
//

import SwiftUI

struct TogglesView: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    var body: some View {
        VStack(spacing: 20) {
            ForEach(SpecialDays.allCases) { item in
                Button {
                    viewModel.new.specialDay = viewModel.new.specialDay == item ? nil : item
                } label: {
                    HStack {
                        Text("\(item.rawValue)").bold()
                            .foregroundColor(viewModel.new.specialDay == item ? Color("Orange") : .gray)
                        Spacer()
                        if viewModel.new.specialDay == item {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color("Orange"))
                        }
                    }
                    .padding()
                    .roundedBackgroundWithBorder
                }
            }
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
}
