//
//  AddDateViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import Foundation
import SwiftUI
import CoreData

final class AddEditDateViewModel: ObservableObject {

    // MARK: Published variables
    @Published var new = New()

    private let parentCoordinator: Coordinator
    private let coordinator: Coordinator

    init(coordinator: Coordinator, parentCoordinator: Coordinator) {
        self.coordinator = coordinator
        self.parentCoordinator = parentCoordinator
    }

    func onTimeInTapped() {
        logPicker(for: .timeIn)
        coordinator.showSheet(.picker(.date(.hourAndMinute, new.timeIn, { [weak self] timeIn in
            DispatchQueue.main.async {
                self?.new.timeIn = timeIn
            }
        })))
    }

    func onTimeOutTapped() {
        logPicker(for: .timeOut)
        coordinator.showSheet(.picker(.date(.hourAndMinute, new.timeOut, { [weak self] timeOut in
            DispatchQueue.main.async {
                self?.new.timeOut = timeOut
            }
        })))
    }

    func onDateTapped() {
        logPicker(for: .date)
        coordinator.showSheet(.picker(.date(.date, new.date, { [weak self] date in
            DispatchQueue.main.async {
                self?.new.date = date
            }
        })))
    }

    func onPauseTapped() {
        logPicker(for: .pause)
        coordinator.showSheet(.picker(.pause(new.secPause, { [weak self] secPause in
            DispatchQueue.main.async {
                self?.new.secPause = secPause
            }
        })))
    }

    func onSaveTapped() {
        parentCoordinator.dismissSheet()
    }

    func onDeleteTapped() {
        parentCoordinator.dismissSheet()
    }
}

// MARK: Analytics
extension AddEditDateViewModel {
    private func logPicker(for pickerType: PickerType?) {
        let analyticsValue: Analytics.Value
        switch pickerType {
        case .pause:
            analyticsValue = .pausePicker
        case .timeIn:
            analyticsValue = .timeInPicker
        case .timeOut:
            analyticsValue = .timeOutPicker
        case .date:
            analyticsValue = .datePicker
        default:
            analyticsValue = .closePicker
        }
        Analytics.logFirebaseClickEvent(analyticsValue)
    }
}
