//
//  HomeViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.11.22.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    // MARK: AppStorage variables
    @AppStorage(Storable.pause.key) var pause: Int = 0
    @AppStorage(Storable.working.key) var working: Bool = false
    @AppStorage(Storable.lastDate.key) var lastDate: Date = Date()

    // MARK: Published variables
    @Published var currentWorkTimeInSec: Int = 0
    @Published var currentCell: HomeCell = .idle

    // MARK: Public variables
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    init() {
        self.currentCell = working ? .working : .idle
    }

    // MARK: Public functions
    func onSwipeButton(action: ((New) -> Void)? = nil) {
        if working {
            let new = createNewDateForEndWork()
            action?(new)
        }
        lastDate = Date()
        refreshWorkTime()
        toggleWorking()
    }

    func refreshWorkTime() {
        currentWorkTimeInSec = Int(Date().timeIntervalSince(lastDate)) - pause
    }

    func checkCurrentWork() { // if user forgot stop working
        if working && abs(lastDate.timeIntervalSince(Date())) > 3600 * 24 {
            toggleWorking()
        }
    }

    // MARK: Private functions
    private func toggleWorking() {
        working.toggle()
        withAnimation(.easeInOut(duration: 1)) {
            self.currentCell = working ? .working : .idle
        }
    }

    private func createNewDateForEndWork() -> New {
        var new = New()
        new.date = lastDate
        new.timeIn = lastDate
        new.timeOut = Date()
        new.secPause = pause
        new.secWork = Int(new.timeOut.timeIntervalSince(new.timeIn)) - new.secPause
        new.night = Calendar.current.component(.day, from: new.timeIn) !=
                    Calendar.current.component(.day, from: new.timeOut)
        new.specialDay = nil
        return new
    }
}
