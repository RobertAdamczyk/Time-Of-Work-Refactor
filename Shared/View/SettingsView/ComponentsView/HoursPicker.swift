//
//  HoursPicker.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.03.21.
//

import SwiftUI

struct HoursPicker: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack(spacing: 20) {
                SettingHeaderView(name: "Hours a week")
                VStack(spacing: 0) {
                    ForEach(1..<51, id: \.self) { index in
                        if index % 5 == 0 {
                            Button {
                                viewModel.hoursWeek = index
                                UserDefaults.standard.setValue(viewModel.hoursWeek, forKey: "hoursWeek")
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                HStack {
                                    Text("\(index)")
                                    Spacer()
                                    if viewModel.hoursWeek == index {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color("Orange"))
                                    }
                                }
                                .font(.system(size: 18, weight: .regular))
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .backgroundWithBottom
                            }

                        }
                    }
                }.overlay(
                    VStack {
                        Rectangle().frame(height: 1)
                            .foregroundColor(Color("BorderColor"))
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
