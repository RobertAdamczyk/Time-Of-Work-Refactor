//
//  AddDateView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 04.03.21.
//

import SwiftUI

struct AddEditDateView: View {
    @StateObject var viewModel = AddEditDateViewModel()
    @Binding var activeSheet: SheetView?
    @Environment(\.colorScheme) var colorScheme
    var date: FetchedResults<Dates>.Element?
    var name: String
    var body: some View {
        ZStack(alignment: .top){

            Color(colorScheme == .light ? "BackgroundColor" : "Black")
                .onTapGesture {
                    viewModel.changeShowComponent(newValue: nil)
                }
            VStack(spacing: 20){
                NewDateRow()
                StartEndRow()
                PauseRow()
                SaveButtonRow(activeSheet: $activeSheet, date: date)
            }
            .environmentObject(viewModel)
            .padding(.horizontal)
            .padding(.top, ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 80)
            AddEditHeaderView(value: name)
            
            
            
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
                    PausePickerView(sec: $viewModel.new.secPause)
                        .transition(.scale)
                default:
                    EmptyView()
                }
                
            }
            .padding(.bottom, 10 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 ))
            
        }
        .ignoresSafeArea()
        .onAppear(){
            if let date = date {
                viewModel.new.date = date.date
                viewModel.new.timeIn = date.timeIn
                viewModel.new.timeOut = date.timeOut
                viewModel.new.night = date.night
                viewModel.new.secPause = date.secPause
            }
        }
    }
}
