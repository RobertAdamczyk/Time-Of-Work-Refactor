//
//  TimeSettingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.03.21.
//

import SwiftUI

struct TimeSettingView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            Color(colorScheme == .light ? "BackgroundColor" : "Black")
                .ignoresSafeArea()
            VStack{
                SettingHeaderView(name: "Time")
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct TimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSettingView()
    }
}
