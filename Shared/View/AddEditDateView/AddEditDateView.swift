//
//  AddDateView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 04.03.21.
//

import SwiftUI

struct AddEditDateView: View {
    @StateObject var viewModel: AddEditDateViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager
    var value: Dates?

    init(coordinator: Coordinator, parentCoordinator: Coordinator, workUnit: Dates? = nil) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator, parentCoordinator: parentCoordinator))
        self.value = workUnit
    }

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
            .navigationTitle(value == nil ? localized(string: "add_date_title") : localized(string: "edit_date_title"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if value != nil {
                        Button {
                            coreDataManager.removeDate(date: value)
                            viewModel.onDeleteTapped()
                        } label: {
                            Text(localized(string: "generic_delete"))
                                .foregroundColor(Color.theme.red)
                        }
                    }
                }
            }
            .overlay(
                Button {
                    Analytics.logFirebaseClickEvent(.addEditSaveButton)
                    if let date = value {
                        coreDataManager.removeDate(date: date)
                        coreDataManager.addDate(for: viewModel.new)
                    } else {
                        coreDataManager.addDate(for: viewModel.new)
                    }
                    viewModel.onSaveTapped()
                } label: {
                    HStack {
                        Spacer()
                        Text(localized(string: "generic_save"))
                            .foregroundColor(Color.theme.buttonText)
                        Spacer()
                    }
                }
                .buttonStyle(OrangeButtonStyle())
                .padding(.horizontal, 16)
                .padding(.bottom, 8), alignment: .bottom)
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
                viewModel.new.hoursSpecialDayInSec = value.specialDay != nil ? Double(value.secWork) : 8
            }
            Analytics.logFirebaseScreenEvent(value == nil ? .addDate : .editDate)
        }
        .environmentObject(viewModel)
        .accentColor(Color.theme.accent)
    }

    var dayNightSection: some View {
        Section {
            Button {
                viewModel.onDateTapped()
            } label: {
                HStack {
                    Text(localized(string: "add_edit_work_day"))
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
                Toggle(localized(string: "add_edit_work_night"), isOn: $viewModel.new.night)
            }
        }
    }

    var startEndTimeSection: some View {
        Section(header: Text(localized(string: "add_edit_start_end_time"))) {
            Button {
                viewModel.onTimeInTapped()
            } label: {
                HStack {
                    Text(localized(string: "generic_start"))
                        .foregroundColor(Color.theme.text)
                    Spacer()
                    Text("\(viewModel.new.timeIn, style: .time)")
                }
            }
            Button {
                viewModel.onTimeOutTapped()
            } label: {
                HStack {
                    Text(localized(string: "generic_end"))
                        .foregroundColor(Color.theme.text)
                    Spacer()
                    Text("\(viewModel.new.timeOut, style: .time)")
                }
            }
        }
    }

    var moreInformationSection: some View {
        Section(header: Text(localized(string: "add_edit_additional_info"))) {
            if viewModel.new.specialDay == nil { // we dont need pause time for for special day
                Button {
                    viewModel.onPauseTapped()
                } label: {
                    HStack {
                        Text(localized(string: "generic_pause"))
                            .foregroundColor(Color.theme.text)
                        Spacer()
                        Text("\(viewModel.new.secPause.toTimeString())")
                    }
                }
            }
            NavigationLink(destination: SpecialDayView(), label: {
                HStack {
                    Text(localized(string: "generic_special_day"))
                    Spacer()
                    if let specialDay = viewModel.new.specialDay {
                        Text("\(specialDay.string)")
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
            Section(header: Text(localized(string: "add_edit_choose_special_day"))) {
                ForEach(SpecialDays.allCases) { item in
                    Button {
                        viewModel.new.specialDay = viewModel.new.specialDay == item ? nil : item
                        Analytics.logFirebaseClickEvent(viewModel.new.specialDay?.analyticsValue ?? "empty")
                    } label: {
                        HStack {
                            Text("\(item.string)")
                                .foregroundColor(Color.theme.text)
                            Spacer()
                            if viewModel.new.specialDay == item {
                                ImageStore.checkmark.image
                                    .foregroundColor(Color.theme.accent)
                            }
                        }
                    }
                }
            }
            Section(header: Text(localized(string: "add_edit_how_many_hours"))) {
                Text("\(Int(viewModel.new.hoursSpecialDayInSec).toTimeString())")
                Slider(value: $viewModel.new.hoursSpecialDayInSec, in: 0...(12 * 3600), step: 600)
            }
        }
        .navigationBarTitle(localized(string: "special_day_title"), displayMode: .inline)
        .onAppear {
            Analytics.logFirebaseScreenEvent(.addEditSpecialDay)
        }
    }
}
