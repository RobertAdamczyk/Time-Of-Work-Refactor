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
    var date: FetchedResults<Dates>.Element?
    var name: String
    var body: some View {
        ZStack(alignment: .top){
            Color("BackgroundColor")
            TabView {
                ZStack{
                    Color("BackgroundColor")
                        .onTapGesture {
                            viewModel.changeShowComponent(newValue: nil)
                        }
                    VStack(spacing: 20){
                        NewDateRow()
                        if viewModel.new.specialDay == nil {
                            StartEndRow()
                            PauseRow()
                        }else {
                            HoursRow()
                        }
                        SaveButtonRow(activeSheet: $activeSheet, date: date)
                        Spacer()
                    }
                    .padding(.top, ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 80)
                    .padding(.horizontal)
                } // Page 1 with Date , Time In, Out, Pause Save Button
                
                ZStack{
                    Color("BackgroundColor")
                        .onTapGesture {
                            viewModel.changeShowComponent(newValue: nil)
                        }
                    TogglesView()
                        .padding(.top, ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 80)
                        .padding(.horizontal)
                } // Page 2 with Holidays Settings
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .environmentObject(viewModel)
            
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
                    PausePickerView(sec: $viewModel.new.secPause)
                        .transition(.scale)
                case .hoursPicker:
                    HoursPickerView(value: $viewModel.hoursCount)
                        .transition(.scale)
                default:
                    EmptyView()
                }
                
            }
            .padding(.bottom, 10 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 ))
            .padding(.horizontal, 15)
            
        }
        .ignoresSafeArea()
        .onAppear(){
            if let date = date {
                viewModel.new.date = date.date
                viewModel.new.timeIn = date.timeIn
                viewModel.new.timeOut = date.timeOut
                viewModel.new.night = date.night
                viewModel.new.secPause = date.secPause
                viewModel.new.specialDay = SpecialDays(rawValue: date.specialDay ?? "")
                viewModel.hoursCount = date.specialDay != nil ? date.secWork / 3600 : 8
            }
        }
    }
}
