//
//  DebugMenuView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 14.12.22.
//
#if DEBUG
import SwiftUI

class DebugMenuViewModel: ObservableObject {

    // MARK: AppStorage variables
    @AppStorage(Storable.pauseTimeInSec.key) var pauseTimeInSec: Int = 0
    @AppStorage(Storable.lastDateForWork.key) var lastDateForWork: Date = Date()
    @AppStorage(Storable.lastDateForPause.key) var lastDateForPause: Date = Date()

    private let parentCoordinator: Coordinator

    init(parentCoordinator: Coordinator) {
        self.parentCoordinator = parentCoordinator
    }

    func onSetLastDateTapped() {
        // TODO: todo
    }
}

struct DebugMenuView: View {
    @StateObject var viewModel: DebugMenuViewModel

    init(parentCoordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(parentCoordinator: parentCoordinator))
    }

    var body: some View {
        Form {
            Section {
                DatePicker("Set last date", selection: $viewModel.lastDateForWork)
                Button {
                    viewModel.onSetLastDateTapped()
                } label: {
                    Text("Start live work")
                }
                Button {
                    // TODO: todo
                } label: {
                    Text("Update live work (pause)")
                }
            }
        }
        .padding(.top, 50)
    }
}

struct DebugMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenuView(parentCoordinator: .init())
    }
}
#endif
