//
//  HomeView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        ZStack{
            VStack{
                HomeHeader(value: "Time Of Work")
                
                DateRow()
                
                ButtonsRow()
                
                if viewModel.working {
                    NowRow()
                        .transition(.move(edge: .leading))
                }
                
                LastWorkView()

                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.changeShowComponent(newValue: nil)
            }
            if viewModel.showComponent == .pausePicker {
                PausePickerView(sec: $viewModel.pause)
                    .offset(y: 150)
                    .transition(.scale)
            }
            if viewModel.showComponent == .timeInPicker {
                TimePickerView(time: $viewModel.lastDate)
                    .offset(y: -100)
                    .transition(.scale)
            }
        }
        .environmentObject(viewModel)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
