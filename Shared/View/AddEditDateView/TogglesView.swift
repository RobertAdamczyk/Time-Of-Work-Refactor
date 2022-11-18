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
                            .foregroundColor(viewModel.new.specialDay == item ? Color.theme.accent : Color.theme.gray)
                        Spacer()
                        if viewModel.new.specialDay == item {
                            Image.store.checkmark
                                .foregroundColor(Color.theme.accent)
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
