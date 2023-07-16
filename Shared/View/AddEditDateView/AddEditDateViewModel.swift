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
        Analytics.logFirebaseClickEvent(.timeInPicker)
        coordinator.showSheet(.picker(.date(.hourAndMinute, new.timeIn, { [weak self] timeIn in
            DispatchQueue.main.async {
                self?.new.timeIn = timeIn
            }
        })))
    }

    func onTimeOutTapped() {
        Analytics.logFirebaseClickEvent(.timeOutPicker)
        coordinator.showSheet(.picker(.date(.hourAndMinute, new.timeOut, { [weak self] timeOut in
            DispatchQueue.main.async {
                self?.new.timeOut = timeOut
            }
        })))
    }

    func onDateTapped() {
        Analytics.logFirebaseClickEvent(.datePicker)
        coordinator.showSheet(.picker(.date(.date, new.date, { [weak self] date in
            DispatchQueue.main.async {
                self?.new.date = date
            }
        })))
    }

    func onPauseTapped() {
        Analytics.logFirebaseClickEvent(.pausePicker)
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
