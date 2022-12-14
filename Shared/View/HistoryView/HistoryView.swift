//
//  HistoryView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @EnvironmentObject var viewModel: HistoryViewModel
    @FetchRequest(entity: Dates.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)])
    var result : FetchedResults<Dates>
    
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView(showsIndicators: false) {
                GeometryReader { reader -> AnyView in
                    let offset = reader.frame(in: .global).minY
                    if !viewModel.showHeader && offset < -50 {
                        DispatchQueue.main.async {
                            withAnimation{
                                viewModel.showHeader = true
                            }
                        }
                    }else if viewModel.showHeader && offset > -50 {
                        DispatchQueue.main.async {
                            withAnimation{
                                viewModel.showHeader = false
                            }
                        }
                    }
                    return AnyView(
                        EmptyView()
                    )
                    
                }.frame(height: 0)
                Spacer().frame(height: ((UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0) + 70)
                HistoryListView(result: result)
                Spacer().frame(height: ((UIApplication.shared.windows.first?.safeAreaInsets.bottom) ?? 0) + 90)
            }
            HistoryHeader(show: $viewModel.showHeader)
                
            
        }
        .onTapGesture {
            withAnimation{
                viewModel.selectedDate = nil
            }
        }
        .onAppear(){
            viewModel.loadArrays(array: result)
        }
        .onReceive(viewModel.refreshHistory) { _ in
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


