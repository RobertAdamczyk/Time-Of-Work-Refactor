//
//  MenuSettingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

struct MenuSettingView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    var body: some View {
        VStack{
            Button(action:{
                viewModel.changeSettingView(new: .workTime)
            }){
                MenuSettingRow(name: "Time")
            }
            
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal)
        .padding(.top, ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 70)
    }
}

struct MenuSettingView_Previews: PreviewProvider {
    static var previews: some View {
        MenuSettingView()
    }
}
