//
//  DaysPicker.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 23.03.21.
//

import SwiftUI

struct DaysPicker: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 20) {
                SettingHeaderView(name: "Days a week")
                VStack(spacing: 0) {
                    ForEach(1..<8) { index in
                        Button {
                            viewModel.daysWeek = index
                            UserDefaults.standard.setValue(viewModel.daysWeek, forKey: "daysWeek")
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Text("\(index)")
                                Spacer()
                                if viewModel.daysWeek == index {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.theme.accent)
                                }
                            }
                            .font(.system(size: 18, weight: .regular))
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .backgroundWithBottom
                        }
                    }
                }.overlay(
                    VStack {
                        Rectangle().frame(height: 1)
                            .foregroundColor(Color.theme.border)
                        Spacer()
                    }
                )
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}
