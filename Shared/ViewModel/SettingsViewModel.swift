//
//  SettingsViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var view: SettingView = .menu
    
    
    func changeSettingView(new: SettingView) {
        withAnimation {
            view = new
        }
    }
}
