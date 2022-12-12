//
//  PickerView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 01.12.22.
//

import SwiftUI

enum PickerType {
    case pause
    case timeIn
    case timeOut
    case date
}

class PickerViewModel: ObservableObject {

    // MARK: Published properties
    @Published var type: PickerType
    @Published var date = Date()

    // MARK: Public properties
    let onCloseAction: () -> Void

    // MARK: Lifecycle
    init(type: PickerType,
         onCloseAction: @escaping () -> Void) {
        self.type = type
        self.onCloseAction = onCloseAction
    }
}

struct PickerView: View {
    @ObservedObject var viewModel: PickerViewModel
    @Binding var date: Date
    @Binding var pause: Int
    init(type: PickerType, date: Binding<Date>, pause: Binding<Int>,
         onCloseAction: @escaping () -> Void) {
        viewModel = PickerViewModel(type: type,
                                    onCloseAction: onCloseAction)
        self._date = date
        self._pause = pause
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.theme.background.opacity(0.01) // need to be opacity, because .clear doesnt work
                .onTapGesture {
                    viewModel.onCloseAction()
                }
            VStack(spacing: 5) {
                HStack {
                    Spacer()
                    Button {
                        viewModel.onCloseAction()
                    } label: {
                        Image.store.close
                            .font(
                                .title3
                                .weight(.semibold)
                            )
                    }
                }
                .padding()
                switch viewModel.type {
                case .date: dateView
                case .timeIn, .timeOut: timeView
                case .pause: PausePickerView(pause: $pause)
                }
            }
            .padding()
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(
                Rectangle()
                    .cornerRadius(50, corners: [.topLeft, .topRight])
                    .foregroundColor(Color.theme.background)
            )
        }
        .ignoresSafeArea()
        .accentColor(Color.theme.accent)
    }

    var dateView: some View {
        DatePicker("", selection: $date, displayedComponents: .date)
            .datePickerStyle(.wheel)
    }

    var timeView: some View {
        DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
            .datePickerStyle(.wheel)
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
                        Text("\(index) h")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/3, height: reader.size.height)
                .compositingGroup()
                .clipped()
                Picker("m", selection: $min) {
                    ForEach(0...59, id: \.self) { index in
                        Text("\(index) m")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/3, height: reader.size.height)
                .compositingGroup()
                .clipped()
                Picker("s", selection: $sec) {
                    ForEach(0...59, id: \.self) { index in
                        Text("\(index) s")
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

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(type: .pause, date: .constant(Date()), pause: .constant(231),
                   onCloseAction: {})
    }
}
