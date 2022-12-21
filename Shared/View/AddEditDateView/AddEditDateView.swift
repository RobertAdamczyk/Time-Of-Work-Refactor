//
//  AddDateView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 04.03.21.
//

import SwiftUI

struct AddEditDateView: View {
    @StateObject var viewModel = AddEditDateViewModel()
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Binding var activeSheet: SheetView?
    var value: Dates?
    var deleteAction: (() -> Void)?
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    dayNightSection
                    if viewModel.new.specialDay == nil { // we dont need start/end time for special day
                        startEndTimeSection
                    }
                    moreInformationSection
                }
            }
            .navigationTitle(value == nil ? "Add Date" : "Edit Date")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if value != nil {
                        Button {
                            deleteAction?()
                        } label: {
                            Text("Delete")
                                .foregroundColor(Color.theme.red)
                        }
                    }
                }
            }
            .overlay(
                Button {
                    activeSheet = nil
                    if let date = value {
                        coreDataManager.removeDate(date: date)
                        coreDataManager.addDate(for: viewModel.new)
                    } else {
                        coreDataManager.addDate(for: viewModel.new)
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Save")
                            .foregroundColor(Color.theme.buttonText)
                        Spacer()
                    }
                }
                .buttonStyle(OrangeButtonStyle())
                .padding(.horizontal, 16)
                .padding(.bottom, 8), alignment: .bottom)
        }
        .overlay(
            ZStack {
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
                        }
                    }
                    .transition(.move(edge: .bottom))
                }
            }
        )
        .ignoresSafeArea()
        .onAppear {
            if let value = value, let timeIn = value.timeIn, let timeOut = value.timeOut, let date = value.date {
                viewModel.new.date = date
                viewModel.new.timeIn = timeIn
                viewModel.new.timeOut = timeOut
                viewModel.new.night = value.night
                viewModel.new.secPause = value.secPause
                viewModel.new.specialDay = SpecialDays(rawValue: value.specialDay ?? "")
                viewModel.new.hoursSpecialDayInSec = value.specialDay != nil ? Double(value.secWork) : 8
            }
        }
        .environmentObject(viewModel)
        .accentColor(Color.theme.accent)
    }

    var dayNightSection: some View {
        Section {
            Button {
                viewModel.showPicker(pickerType: .date)
            } label: {
                HStack {
                    Text("Work day")
                        .foregroundColor(Color.theme.text)
                    Spacer()
                    if viewModel.new.night, let datePlusOneDay = viewModel.new.date.plusOneDay() {
                        Text("\(viewModel.new.date.toString(format: .shortDate)) -")
                        Text("\(datePlusOneDay.toString(format: .shortDateWithYear))")
                    } else {
                        Text("\(viewModel.new.date, style: .date)")
                    }
                }
            }
            if viewModel.new.specialDay == nil { // don't need work at night for special day
                Toggle("Work at the night", isOn: $viewModel.new.night)
            }
        }
    }

    var startEndTimeSection: some View {
        Section(header: Text("Your start and finish time.")) {
            Button {
                viewModel.showPicker(pickerType: .timeIn)
            } label: {
                HStack {
                    Text("Start")
                        .foregroundColor(Color.theme.text)
                    Spacer()
                    Text("\(viewModel.new.timeIn, style: .time)")
                }
            }
            Button {
                viewModel.showPicker(pickerType: .timeOut)
            } label: {
                HStack {
                    Text("End")
                        .foregroundColor(Color.theme.text)
                    Spacer()
                    Text("\(viewModel.new.timeOut, style: .time)")
                }
            }
        }
    }

    var moreInformationSection: some View {
        Section(header: Text("Additional information")) {
            if viewModel.new.specialDay == nil { // we dont need pause time for for special day
                Button {
                    viewModel.showPicker(pickerType: .pause)
                } label: {
                    HStack {
                        Text("Pause")
                            .foregroundColor(Color.theme.text)
                        Spacer()
                        Text("\(viewModel.new.secPause.toTimeString())")
                    }
                }
            }
            NavigationLink(destination: SpecialDayView(), label: {
                HStack {
                    Text("Special Day")
                    Spacer()
                    if let specialDay = viewModel.new.specialDay {
                        Text("\(specialDay.rawValue)")
                    }
                }
            })
        }
    }
}

struct SpecialDayView: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    var body: some View {
        Form {
            Section(header: Text("Choose your special day")) {
                ForEach(SpecialDays.allCases) { item in
                    Button {
                        viewModel.new.specialDay = viewModel.new.specialDay == item ? nil : item
                    } label: {
                        HStack {
                            Text("\(item.rawValue)")
                                .foregroundColor(Color.theme.text)
                            Spacer()
                            if viewModel.new.specialDay == item {
                                Image.store.checkmark
                                    .foregroundColor(Color.theme.accent)
                            }
                        }
                    }
                }
            }
            Section(header: Text("How many hours")) {
                Text("\(Int(viewModel.new.hoursSpecialDayInSec).toTimeString())")
                Slider(value: $viewModel.new.hoursSpecialDayInSec, in: 0...(12 * 3600), step: 600)
            }
        }
        .navigationBarTitle("Special Day", displayMode: .inline)
    }
}
