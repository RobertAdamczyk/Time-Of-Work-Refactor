//
//  MainView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct MainView: View {
    @State var view = Views.home
    @State var showAddDate = false
    var body: some View {
        ZStack(alignment: .bottom){
            Color("BackgroundColor")
            VStack{
                if view == .home {
                    HomeView()
                }
                if view == .history {
                    HistoryView()
                }
            }
            
            ToolbarView(view: $view, showAddDate: $showAddDate)
            
            
        }
        .sheet(isPresented: $showAddDate){
            AddDateView(showSheet: $showAddDate)
        }
        .ignoresSafeArea(.all)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
