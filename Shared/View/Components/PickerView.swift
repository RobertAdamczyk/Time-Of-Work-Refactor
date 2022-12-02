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
    case special
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
    @State var value1: Int = 0
    @State var value2: Int = 0
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
                case .pause: pauseView
                case .special: EmptyView()
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

    var pauseView: some View {
        GeometryReader { reader in
            HStack(spacing: 0) {
                Picker("h", selection: $value1) {
                    ForEach(0...23, id: \.self) { index in
                        Text("\(index) h")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/2, height: reader.size.height)
                .compositingGroup()
                .clipped()
                Picker("h", selection: $value2) {
                    ForEach(0...59, id: \.self) { index in
                        Text("\(index) m")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/2, height: reader.size.height)
                .compositingGroup()
                .clipped()
            }
            .onChange(of: value1) { _ in
                self.pause = value1 * 3600 + value2 * 60
            }
            .onChange(of: value2) { _ in
                self.pause = value1 * 3600 + value2 * 60
            }
            .onAppear {
                value1 = self.pause / 3600
                value2 = self.pause % 3600 / 60
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
