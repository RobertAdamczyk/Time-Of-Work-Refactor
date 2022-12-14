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
    var body: some View {
        ZStack {
            Color.theme.background
            Text("Debug")
        }
    }
}

struct DebugMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenuView()
    }
}
