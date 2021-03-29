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
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack(spacing: 20){
                SettingHeaderView(name: "Days a week")
                VStack(spacing: 0){
                    ForEach(1..<8) { i in
                        Button(action:{
                            viewModel.daysWeek = i
                            UserDefaults.standard.setValue(viewModel.daysWeek, forKey: "daysWeek")
                            presentationMode.wrappedValue.dismiss()
                        }){
                            HStack{
                                Text("\(i)")
                                Spacer()
                                if viewModel.daysWeek == i {
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
                }.overlay(
                    VStack{
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
