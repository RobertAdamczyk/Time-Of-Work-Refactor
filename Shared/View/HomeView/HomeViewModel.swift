//
//  HomeViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.11.22.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    // MARK: AppStorage variables
    @AppStorage(Storable.pauseTimeInSec.key) var pauseTimeInSec: Int = 0
    @AppStorage(Storable.working.key) var working: Bool = false
    @AppStorage(Storable.isPauseOn.key) var isPauseOn: Bool = false
    @AppStorage(Storable.defaultPauseSetting.key) var defaultPauseSetting: Bool = false
    @AppStorage(Storable.defaultPauseInSecSetting.key) var defaultPauseInSecSetting: Int = 0
    @AppStorage(Storable.lastDateForWork.key) var lastDateForWork: Date = Date()
    @AppStorage(Storable.lastDateForPause.key) var lastDateForPause: Date = Date()

    // MARK: Published variables
    @Published var currentWorkTimeInSec: Int = 0
    @Published var currentPauseTimeInSec: Int = 0
    @Published var currentCell: HomeCell = .idle

    @Published var lastWorkUnit: WorkUnit?

    // MARK: Public variables
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private let coordinator: Coordinator
    private var workUnitsTask: Task<(), Never>?

    @Dependency private var dependencies: Dependencies

    // MARK: Lifecycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.currentCell = working ? .working : .idle
    }

    func onViewAppear() {
        setupWorkUnitsObserver()
        Analytics.logFirebaseScreenEvent(.homeScreen)
        dependencies.coreDataService.fetchWorkUnits()
    }

    func onViewDisappear() {
        workUnitsTask?.cancel()
        workUnitsTask = nil
    }

    // MARK: Public functions

    func onPauseTapped() {
        Analytics.logFirebaseClickEvent(.pausePicker)
        coordinator.showSheet(.picker(.pause(pauseTimeInSec, { [weak self] pauseSec in
            DispatchQueue.main.async {
                self?.pauseTimeInSec = pauseSec
            }
        })))
    }

    func onTimeInTapped() {
        Analytics.logFirebaseClickEvent(.timeInPicker)
        coordinator.showSheet(.picker(.date(.hourAndMinute, lastDateForWork, { [weak self] date in
            DispatchQueue.main.async {
                self?.lastDateForWork = date
            }
        })))
    }

    func onSwipeWorkButton() {
        if isPauseOn {
            pauseTimeInSec += currentPauseTimeInSec
        }
        if working {
            Analytics.logFirebaseSwipeEvent(.endWork)
            let workUnit = createNewDateForEndWork()
            dependencies.coreDataService.addWorkUnit(for: workUnit)
            dependencies.liveActivitiesService.removeLiveWork()
        } else {
            Analytics.logFirebaseSwipeEvent(.startWork)
            lastDateForWork = Date()
            dependencies.liveActivitiesService.startLiveWork(for: .work,
                                                             date: lastDateForWork,
                                                             startWorkDate: lastDateForWork,
                                                             pauseInSec: pauseTimeInSec,
                                                             workInSec: currentWorkTimeInSec)
        }
        toggleWorking()
    }

    func onSwipePauseButton() {
        lastDateForPause = Date()
        if isPauseOn {
            Analytics.logFirebaseSwipeEvent(.endPause)
            pauseTimeInSec += currentPauseTimeInSec
        } else {
            Analytics.logFirebaseSwipeEvent(.startPause)
        }
        currentPauseTimeInSec = 0
        withAnimation(.easeIn) {
            isPauseOn.toggle()
        }
        updateLiveWork()
    }

    func refreshWorkTime() {
        if isPauseOn {
            currentPauseTimeInSec = Int(Date().timeIntervalSince(lastDateForPause))
            let pauseTogether = pauseTimeInSec + currentPauseTimeInSec
            currentWorkTimeInSec = Int(Date().timeIntervalSince(lastDateForWork)) - pauseTogether
        } else {
            currentWorkTimeInSec = Int(Date().timeIntervalSince(lastDateForWork)) - pauseTimeInSec
        }
    }

    func checkCurrentWork() { // if user forgot stop working
        if working && abs(lastDateForWork.timeIntervalSince(Date())) > Config.automaticCheckoutAfterSec {
            toggleWorking()
        }
    }

    func updateLiveWork() {
        dependencies.liveActivitiesService.updateLiveWork(for: isPauseOn ? .pause : .work,
                                                          date: isPauseOn ? lastDateForPause : lastDateForWork,
                                                          startWorkDate: lastDateForWork,
                                                          pauseInSec: pauseTimeInSec,
                                                          workInSec: currentWorkTimeInSec)
    }

    func handleDeeplink(for url: URL) {
        if let deepLink = LiveActivitiesService.DeepLink(rawValue: url.absoluteString) {
            switch deepLink {
            case .pauseButton:
                Analytics.logFirebaseClickEvent(.pauseLiveWork)
                onSwipePauseButton()
            case .endWorkButton:
                Analytics.logFirebaseClickEvent(.endLiveWork)
                onSwipeWorkButton()
            }
        }
    }

    // MARK: Private functions

    private func setupWorkUnitsObserver() {
        workUnitsTask = Task { [weak self] in
            guard let self else { return }
            for await observedUnits in dependencies.coreDataService.$workUnits.values {
                await MainActor.run {
                    self.lastWorkUnit = observedUnits.first
                }
            }
        }
    }

    private func toggleWorking() {
        working.toggle()
        withAnimation(.easeInOut(duration: 1)) {
            self.currentCell = working ? .working : .idle
        }
        isPauseOn = false
        pauseTimeInSec = defaultPauseSetting ? defaultPauseInSecSetting : 0
        currentPauseTimeInSec = 0
    }

    private func createNewDateForEndWork() -> New {
        var new = New()
        new.date = lastDateForWork
        new.timeIn = lastDateForWork
        new.timeOut = Date()
        new.secPause = pauseTimeInSec
        new.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
        new.night = Calendar.current.component(.day, from: new.timeIn) !=
                    Calendar.current.component(.day, from: new.timeOut)
        new.specialDay = nil
        return new
    }
}
