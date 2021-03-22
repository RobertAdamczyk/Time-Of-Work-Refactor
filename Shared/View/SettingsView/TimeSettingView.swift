//
//  TimeSettingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.03.21.
//

import SwiftUI

struct TimeSettingView: View {
    @EnvironmentObject var viewModel : SettingsViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            Color(colorScheme == .light ? "BackgroundColor" : "Black")
                .ignoresSafeArea()
            VStack(spacing: 0){
                SettingHeaderView(name: "Time")
                    .padding(.bottom, 20)
                NavigationLink(destination: HoursPicker()) {
                    MenuSettingRow(name: "Hours a week", value: "\(viewModel.hoursWeek)")
                        .backgroundWithBottomTop
                }
                MenuSettingRow(name: "Days a week", value: "\(viewModel.daysWeek)")
                    .backgroundWithBottom
                Spacer()
            }
            .font(.system(size: 18, weight: .semibold))
        }
        .navigationBarHidden(true)
    }
}

struct TimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSettingView()
    }
}
