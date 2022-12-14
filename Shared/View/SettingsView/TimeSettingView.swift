//
//  TimeSettingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.03.21.
//

import SwiftUI

struct TimeSettingView: View {
    @EnvironmentObject var viewModel : SettingsViewModel
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20){
                SettingHeaderView(name: "Time")
                VStack(spacing: 0){
                    NavigationLink(destination: HoursPicker()) {
                        RowSetting(name: "Hours a week", value: "\(viewModel.hoursWeek)")
                            .backgroundWithBottomTop
                    }
                    NavigationLink(destination: DaysPicker()) {
                        RowSetting(name: "Days a week", value: "\(viewModel.daysWeek)")
                            .backgroundWithBottom
                    }
                    
                }.buttonStyle(PlainButtonStyle())
                
                Text("Set your time of work.")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.top, -5)
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
