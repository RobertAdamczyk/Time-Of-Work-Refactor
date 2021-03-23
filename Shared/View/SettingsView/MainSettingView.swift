//
//  SettingsView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

struct MainSettingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView{
            ZStack{
                Color(colorScheme == .light ? "BackgroundColor" : "Black")
                    .ignoresSafeArea()
                VStack(spacing: 20){
                    AddEditHeaderView(value: "Settings")
                    
                    VStack(alignment: .leading){
                        NavigationLink(destination: TimeSettingView()) {
                            RowSetting(name: "Time")
                                .backgroundWithBottomTop
                        }
                        Text("Set your time of work.")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.horizontal)
                    } // Time row in menu
                    
                    
                    Spacer()
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        
    }
}
