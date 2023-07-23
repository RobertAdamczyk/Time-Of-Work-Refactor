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

    var navigationTitle: String {
        workUnit == nil ? localized(string: "add_date_title") : localized(string: "edit_date_title")
    }

    var shouldShowDeleteButton: Bool {
        workUnit != nil
    }

    private let parentCoordinator: Coordinator
    private let coordinator: Coordinator
    private let workUnit: WorkUnit?

    @Dependency private var dependencies: Dependencies

    init(coordinator: Coordinator, parentCoordinator: Coordinator, workUnit: WorkUnit?) {
        self.coordinator = coordinator
        self.parentCoordinator = parentCoordinator
        self.workUnit = workUnit
        if let workUnit, let timeIn = workUnit.timeIn, let timeOut = workUnit.timeOut, let date = workUnit.date {
            new.date = date // TODO: Make custom init
            new.timeIn = timeIn
            new.timeOut = timeOut
            new.night = workUnit.night
            new.secPause = workUnit.secPause
            new.specialDay = SpecialDays(rawValue: workUnit.specialDay ?? "")
            new.hoursSpecialDayInSec = workUnit.specialDay != nil ? Double(workUnit.secWork) : 8
        }
    }

    func onViewAppear() {
        Analytics.logFirebaseScreenEvent(workUnit == nil ? .addDate : .editDate)
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
        Analytics.logFirebaseClickEvent(.addEditSaveButton)
        if let workUnit {
            dependencies.coreDataService.removeWorkUnit(workUnit)
            dependencies.coreDataService.addWorkUnit(for: new)
        } else {
            dependencies.coreDataService.addWorkUnit(for: new)
        }
        parentCoordinator.dismissSheet()
    }

    func onDeleteTapped() {
        dependencies.coreDataService.removeWorkUnit(workUnit)
        parentCoordinator.dismissSheet()
    }
}
