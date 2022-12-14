//
//  Time_Of_WorkApp.swift
//  Shared
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

@main
struct Time_Of_WorkApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
