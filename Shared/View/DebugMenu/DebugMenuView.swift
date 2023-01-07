//
//  DebugMenuView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 14.12.22.
//
#if DEBUG
import SwiftUI

class DebugMenuViewModel: ObservableObject {
    @Published var showDebugMenu: Bool = false

    let liveWorkViewModel = LiveWorkViewModel()

    func showMenu() {
        withAnimation {
            showDebugMenu.toggle()
        }
    }
}

struct DebugMenuView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var viewModel: DebugMenuViewModel
    var body: some View {
        Form {
            Section {
                DatePicker("Set last date", selection: $homeViewModel.lastDateForWork)
                Button {
                    viewModel.liveWorkViewModel.startLiveWork(for: .work,
                                                              date: homeViewModel.lastDateForWork,
                                                              startWorkDate: homeViewModel.lastDateForWork,
                                                              pauseInSec: homeViewModel.pauseTimeInSec,
                                                              workInSec: homeViewModel.currentWorkTimeInSec)
                } label: {
                    Text("Start live work")
                }
                Button {
                    viewModel.liveWorkViewModel.updateLiveWork(for: .pause,
                                                               date: Date(), // aktualna data zaktualizowania ??
                                                               startWorkDate: homeViewModel.lastDateForWork,
                                                               pauseInSec: homeViewModel.pauseTimeInSec,
                                                               workInSec: homeViewModel.currentWorkTimeInSec)
                } label: {
                    Text("Update live work (pause)")
                }
                Button {
                    viewModel.showDebugMenu.toggle()
                } label: {
                    Text("Close debug menu")
                }
            }
        }
        .padding(.top, 50)
    }
}

struct DebugMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenuView()
    }
}
#endif
