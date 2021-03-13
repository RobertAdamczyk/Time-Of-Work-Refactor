//
//  AddDateView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 04.03.21.
//

import SwiftUI

struct AddDateView: View {
    @StateObject var viewModel = AddDateViewModel()
    @Binding var showSheet: Bool
    var body: some View {
        ZStack(alignment: .top){
            Color("BackgroundColor")
                .onTapGesture {
                    viewModel.changeShowComponent(newValue: nil)
                }
            VStack(spacing: 20){
                if viewModel.showError {
                    Text("Start of work can't be bigger or equals than end.")
                        .foregroundColor(.red)
                        .padding(.vertical, -5)
                }
                NewDateRow()
                StartEndRow()
                PauseRow()
                SaveButtonRow(showSheet: $showSheet)
            }
            .environmentObject(viewModel)
            .padding(.horizontal)
            .padding(.top, ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 70)
            HomeHeader(value: "New Date") // file in HomeView folder
            
            
            
            ZStack(alignment: .bottom){
                Color.clear
                switch(viewModel.showComponent) {
                case .datePicker:
                    DatePickerView(date: $viewModel.new.date, night: $viewModel.new.night)
                        .transition(.scale)  
                case .timeInPicker:
                    TimePickerView(time: $viewModel.new.timeIn)
                        .transition(.scale)
                case .timeOutPicker:
                    TimePickerView(time: $viewModel.new.timeOut)
                        .transition(.scale)
                case .pausePicker:
                    //TimePickerView(time: $viewModel.new.pause)
                    PausePickerView(date: $viewModel.new.pause)
                        .transition(.scale)
                default:
                    EmptyView()
                }
                
            }
            .padding(.bottom, 10 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 ))
            
        }
        .ignoresSafeArea()
    }
}

struct AddDateView_Previews: PreviewProvider {
    static var previews: some View {
        AddDateView(showSheet: .constant(true))
            .preferredColorScheme(.light)
    }
}
