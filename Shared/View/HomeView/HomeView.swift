//
//  HomeView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            HomeHeader(value: "Time Of Work")
            
            DateRow()
            
            ButtonsRow()
            
            TodayRow()

            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
