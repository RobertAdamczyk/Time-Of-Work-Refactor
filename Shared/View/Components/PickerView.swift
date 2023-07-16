//
//  PickerView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 01.12.22.
//

import SwiftUI

enum PickerTypeV2 {
    case pause(Int, (Int) -> Void)
    case date(DatePickerComponents, Date, (Date) -> Void)
}

final class PickerViewModelV2: ObservableObject {

    @Published var date: Date = .init() {
        didSet {
            onSet()
        }
    }
    @Published var pause: Int = 0 {
        didSet {
            onSet()
        }
    }

    let type: PickerTypeV2
    var datePickerComponents: DatePickerComponents = .date

    private let parentCoordinator: Coordinator

    init(type: PickerTypeV2, parentCoordinator: Coordinator) {
        self.parentCoordinator = parentCoordinator
        self.type = type
        switch type {
        case .pause(let int, _):
            self.pause = int
        case .date(let components, let date, _):
            self.date = date
            self.datePickerComponents = components
        }
    }

    func onSet() {
        switch type {
        case .pause(_, let completion):
            completion(pause)
        case .date(_, _, let completion):
            completion(date)
        }
    }

    func onViewDisappear() {
        Analytics.logFirebaseClickEvent(.closePicker)
    }
}

struct PickerViewV2: View {

    @StateObject var viewModel: PickerViewModelV2

    init(type: PickerTypeV2, parentCoordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(type: type, parentCoordinator: parentCoordinator))
    }

    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            switch viewModel.type {
            case .date: datePicker
            case .pause: pausePicker
            }
        }
        .onDisappear(perform: viewModel.onViewDisappear)
    }

    var datePicker: some View {
        DatePicker("", selection: $viewModel.date, displayedComponents: viewModel.datePickerComponents)
            .datePickerStyle(.wheel)
            .labelsHidden()
    }

    var pausePicker: some View {
        PausePickerView(pause: $viewModel.pause)
    }
}

struct PausePickerView: View {
    @Binding var pause: Int
    @State var hour: Int = 0
    @State var min: Int = 0
    @State var sec: Int = 0
    var body: some View {
        GeometryReader { reader in
            HStack(spacing: 0) {
                Picker("h", selection: $hour) {
                    ForEach(0...23, id: \.self) { index in
                        Text("\(index) \(localized(string: "prefix_hours"))")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/3, height: reader.size.height)
                .compositingGroup()
                .clipped()
                Picker("m", selection: $min) {
                    ForEach(0...59, id: \.self) { index in
                        Text("\(index) \(localized(string: "prefix_minutes"))")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/3, height: reader.size.height)
                .compositingGroup()
                .clipped()
                Picker("s", selection: $sec) {
                    ForEach(0...59, id: \.self) { index in
                        Text("\(index) \(localized(string: "prefix_seconds"))")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/3, height: reader.size.height)
                .compositingGroup()
                .clipped()
            }
            .onChange(of: hour) { _ in
                self.pause = hour * 3600 + min * 60 + sec
            }
            .onChange(of: min) { _ in
                self.pause = hour * 3600 + min * 60 + sec
            }
            .onChange(of: sec) { _ in
                self.pause = hour * 3600 + min * 60 + sec
            }
            .onAppear {
                hour = self.pause / 3600
                min = self.pause % 3600 / 60
                sec = self.pause % 3600 % 60
            }
        }
        .frame(height: 220)
    }
}
