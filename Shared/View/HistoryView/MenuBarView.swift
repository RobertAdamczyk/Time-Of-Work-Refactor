//(
//  MenuBarView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 14.03.21.
//

import SwiftUI

struct MenuBarView: View {
    var date: FetchedResults<Dates>.Element?
    @EnvironmentObject var viewModel: HistoryViewModel
    
    var body: some View {
        if viewModel.selectedDate == date {
            HStack{
                Spacer()
                Button(action:{
                    
                }){
                    Text("Edit")
                        .padding(6)
                        .frame(width: 80)
                        .background(Color("Orange").opacity(0.9).cornerRadius(10))
                        
                }
                Button(action:{
                    
                }){
                    Text("Delete")
                        .padding(6)
                        .frame(width: 80)
                        .background(Color.red.opacity(0.9).cornerRadius(10))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .transition(.move(edge: .trailing))
            .padding(.horizontal, 5)
        }else{
            EmptyView()
        }
        
    }
}

