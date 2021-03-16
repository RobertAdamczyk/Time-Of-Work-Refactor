//
//  MainView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var view = Views.home
    @Published var activeSheet: SheetView?
}

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    @ObservedObject var historyViewModel = HistoryViewModel()
    var body: some View {
        ZStack(alignment: .bottom){
            Color("BackgroundColor")
                
            VStack{
                if viewModel.view == .home {
                    HomeView()
                        .environmentObject(homeViewModel)
                }
                if viewModel.view == .history {
                    HistoryView()
                        .environmentObject(historyViewModel)
                }
            }
            ToolbarView()
        }
        .environmentObject(viewModel)
        .sheet(item: $viewModel.activeSheet){ item in
            switch(item) {
            case .addDate:
                AddEditDateView(activeSheet: $viewModel.activeSheet, name: "New Date")
            case .editDate:
                AddEditDateView(activeSheet: $viewModel.activeSheet, date: historyViewModel.selectedDate, name: "Edit Date")
            }
            
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
