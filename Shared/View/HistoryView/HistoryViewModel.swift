//
//  HistoryViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 26.11.22.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {

    // MARK: Published properties
    @Published var sectionType: SectionType

    @Published var workUnits: [WorkUnit] = []

    @Dependency private var dependencies: Dependencies

    private let coordinator: Coordinator
    private var workUnitsTask: Task<(), Never>?

    // MARK: Lifecycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.sectionType = .week
        setupWorkUnitsObserver()
    }

    func onViewAppear() {
        Analytics.logFirebaseScreenEvent(.history)
        dependencies.coreDataService.fetchWorkUnits()
    }

    // MARK: Public functions

    func onSectionButtonTapped() {
        Analytics.logFirebaseClickEvent(.historySection)
        DispatchQueue.main.async { [weak self] in
            self?.changeSectionType()
        }
    }

    func onHistoryRowTapped(date: Dates) {
        coordinator.showSheet(.editDate(date))
    }

    // MARK: Private functions

    private func setupWorkUnitsObserver() {
        workUnitsTask = Task { [weak self] in
            guard let self else { return }
            for await observedUnits in dependencies.coreDataService.$workUnits.values {
                await MainActor.run {
                    self.workUnits = observedUnits
                }
            }
        }
    }

    private func changeSectionType() {
        switch sectionType {
        case .week:
            sectionType = .month
        case .month:
            sectionType = .year
        case .year:
            sectionType = .week
        }
    }
}

// MARK: SectionType
extension HistoryViewModel {
    enum SectionType {
        case week
        case month
        case year

        var components: (first: Calendar.Component, second: Calendar.Component?) {
            switch self {
            case .week:
                return (first: .weekOfYear, second: .yearForWeekOfYear)
            case .month:
                return (first: .month, second: .year)
            case .year:
                return (first: .year, second: nil)
            }
        }

        private func value(for date: Dates) -> (first: String, second: String) {
            guard let date = date.date else { return (first: "", second: "") }
            let firstValueFoSection = String(Calendar.current.component(self.components.first, from: date))
            let secondValueFoSection: String
            if let value = self.components.second {
                secondValueFoSection = "/" + String(Calendar.current.component(value, from: date))
            } else {
                secondValueFoSection = ""
            }
            return (first: firstValueFoSection, second: secondValueFoSection)
        }

        func sectionText(for unit: WorkUnit) -> String {
            return "\(self.value(for: unit).first)\(self.value(for: unit).second)"
        }

        var name: String {
            switch self {
            case .week:
                return localized(string: "generic_week")
            case .month:
                return localized(string: "generic_month")
            case .year:
                return localized(string: "generic_year")
            }
        }
    }
}
