//
//  DebugMenuView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 14.12.22.
//

import SwiftUI

class DebugMenuViewModel: ObservableObject {
    @Published var showDebugMenu: Bool = false

    func showMenu() {
        withAnimation {
            showDebugMenu.toggle()
        }
    }
}

struct DebugMenuView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    var body: some View {
        Form {
            DatePicker("Set last date", selection: $homeViewModel.lastDateForWork)
        }
    }
}

struct DebugMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenuView()
    }
}
