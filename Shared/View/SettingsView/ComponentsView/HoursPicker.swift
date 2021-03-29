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
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack(spacing: 20){
                SettingHeaderView(name: "Hours a week")
                VStack(spacing: 0){
                    ForEach(1..<51) { i in
                        if i % 5 == 0 {
                            Button(action:{
                                viewModel.hoursWeek = i
                                UserDefaults.standard.setValue(viewModel.hoursWeek, forKey: "hoursWeek")
                                presentationMode.wrappedValue.dismiss()
                            }){
                                HStack{
                                    Text("\(i)")
                                    Spacer()
                                    if viewModel.hoursWeek == i {
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

