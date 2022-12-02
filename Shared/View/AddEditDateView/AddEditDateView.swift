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
    var deleteAction: (() -> Void)?
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.theme.background
                TabView {
                    ZStack {
                        Color.theme.background
                            .onTapGesture {
                                viewModel.showPicker(pickerType: nil)
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
                                viewModel.showPicker(pickerType: nil)
                            }
                        TogglesView()
                            .padding(.top, ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 80)
                            .padding(.horizontal)
                    } // Page 2 with Holidays Settings
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .environmentObject(viewModel)

                AddEditHeaderView(deleteAction: deleteAction, value: value)
            }
            .zIndex(0)
            if let pickerType = viewModel.showPickerType {
                ZStack {
                    switch pickerType {
                    case .pause:
                        PickerView(type: pickerType, date: $viewModel.new.date,
                                   pause: $viewModel.new.secPause, onCloseAction: {
                            viewModel.showPicker(pickerType: nil)
                        })
                    case .timeIn:
                        PickerView(type: pickerType, date: $viewModel.new.timeIn,
                                   pause: $viewModel.new.secPause, onCloseAction: {
                            viewModel.showPicker(pickerType: nil)
                        })
                    case .timeOut:
                        PickerView(type: pickerType, date: $viewModel.new.timeOut,
                                   pause: $viewModel.new.secPause, onCloseAction: {
                            viewModel.showPicker(pickerType: nil)
                        })
                    case .date:
                        PickerView(type: pickerType, date: $viewModel.new.date,
                                   pause: $viewModel.new.secPause, onCloseAction: {
                            viewModel.showPicker(pickerType: nil)
                        })
                    case .special:
                        EmptyView()
                    }
                }
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
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
