//
//  HistoryView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()
    @FetchRequest(entity: Dates.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)])
    var result : FetchedResults<Dates>
    
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView(showsIndicators: false) {
                GeometryReader { reader -> AnyView in
                    DispatchQueue.main.async {
                        withAnimation{
                            if reader.frame(in: .global).minY < -50 {
                                viewModel.showHeader = true
                            }
                            else {
                                viewModel.showHeader = false
                            }
                        }
                    }
                    return AnyView(EmptyView())
                }.frame(height: 0)
                Spacer().frame(height: ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 70)
                HistoryListView(result: result)
                    .environmentObject(viewModel)
                
            }
            HistoryHeader(show: $viewModel.showHeader)
            
        }.onAppear(){
            viewModel.loadArrays(array: result)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}


