//
//  SettingsView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

struct MainSettingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    AddEditHeaderView(value: "Settings")
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("User Preferences")
                        }
                        .foregroundColor(Color.theme.gray)
                        .font(.subheadline)
                        .padding(.horizontal)
                        NavigationLink(destination: TimeSettingView()) {
                            RowSetting(name: "Time")
                                .backgroundWithBottomTop
                        }
                    } // Time row in menu
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "info")
                            Text("Info")
                        }
                        .foregroundColor(Color.theme.gray)
                        .font(.subheadline)
                        .padding(.horizontal)
                        NavigationLink(destination: AboutView()) {
                            RowSetting(name: "About")
                                .backgroundWithBottomTop
                        }
                    }
                    Spacer()
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
    }
}
