//
//  ContentView.swift
//  Shared
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct ContentView: View {
    init() {
        /// Orange title in navigations view
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
    }
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
