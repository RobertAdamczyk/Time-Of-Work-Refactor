//
//  HomeView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            
            VStack{
                HomeHeader(value: "Time Of Work")
                
                DateRow()
                
                ButtonsRow()
                
                TodayRow()

                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if viewModel.showPausePicker {
                    withAnimation{
                        viewModel.showPausePicker.toggle()
                    }
                }
            }
            if viewModel.showPausePicker {
                PausePickerView(sec: $viewModel.pause)
                    .offset(y: 150)
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
