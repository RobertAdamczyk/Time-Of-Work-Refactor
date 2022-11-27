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
                    HStack {
                        Text("Settings")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.accent)
                        Spacer()
                    }
                    .padding(.horizontal, 5)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding(10)
                    .backgroundWithBottom
                    VStack(alignment: .leading) {
                        HStack {
                            Image.store.person
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
                            Image.store.info
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
