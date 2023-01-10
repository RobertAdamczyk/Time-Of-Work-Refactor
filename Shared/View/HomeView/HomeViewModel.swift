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

    // MARK: Public variables
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let liveWorkViewModel = LiveWorkViewModel()

    // MARK: Lifecycle
    init() {
        self.currentCell = working ? .working : .idle
    }

    // MARK: Public functions
    func onSwipeWorkButton(action: ((New) -> Void)? = nil) {
        if isPauseOn {
            pauseTimeInSec += currentPauseTimeInSec
        }
        if working {
            let new = createNewDateForEndWork()
            action?(new)
            liveWorkViewModel.removeLiveWork()
        } else {
            lastDateForWork = Date()
            liveWorkViewModel.startLiveWork(for: .work,
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
            pauseTimeInSec += currentPauseTimeInSec
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
        liveWorkViewModel.updateLiveWork(for: isPauseOn ? .pause : .work,
                                         date: isPauseOn ? lastDateForPause : lastDateForWork,
                                         startWorkDate: lastDateForWork,
                                         pauseInSec: pauseTimeInSec,
                                         workInSec: currentWorkTimeInSec)
    }

    // MARK: Private functions
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
