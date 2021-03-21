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
        VStack(spacing: 20){
            AddEditHeaderView(value: "Settings")
            
            VStack{
                Button(action:{
                    viewModel.changeSettingView(new: .workTime)
                }){
                    MenuSettingRow(name: "Time")
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
        }
        
    }
}

struct MenuSettingView_Previews: PreviewProvider {
    static var previews: some View {
        MenuSettingView()
    }
}
