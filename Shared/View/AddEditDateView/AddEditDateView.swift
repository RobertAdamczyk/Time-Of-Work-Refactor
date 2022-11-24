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
    var value: Dates?
    var name: String
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.background
            TabView {
                ZStack {
                    Color.theme.background
                        .onTapGesture {
                            viewModel.changeShowComponent(newValue: nil)
                        }
                    VStack(spacing: 20) {
                        NewDateRow()
                        if viewModel.new.specialDay == nil {
                            StartEndRow()
                            PauseRow()
                        } else {
                            HoursRow()
                        }
                        SaveButtonRow(activeSheet: $activeSheet, date: value)
                        Spacer()
                    }
                    .padding(.top, ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 80)
                    .padding(.horizontal)
                } // Page 1 with Date , Time In, Out, Pause Save Button
                ZStack {
                    Color.theme.background
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

            ZStack(alignment: .bottom) {
                Color.clear
                switch viewModel.showComponent {
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
                    HoursPickerView(value: $viewModel.new.hoursSpecialDay)
                        .transition(.scale)
                default:
                    EmptyView()
                }
            }
            .padding(.bottom, 10 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 ))
            .padding(.horizontal, 15)
        }
        .ignoresSafeArea()
        .onAppear {
            if let value = value, let timeIn = value.timeIn, let timeOut = value.timeOut, let date = value.date {
                viewModel.new.date = date
                viewModel.new.timeIn = timeIn
                viewModel.new.timeOut = timeOut
                viewModel.new.night = value.night
                viewModel.new.secPause = value.secPause
                viewModel.new.specialDay = SpecialDays(rawValue: value.specialDay ?? "")
                viewModel.new.hoursSpecialDay = value.specialDay != nil ? value.secWork / 3600 : 8
            }
        }
    }
}
