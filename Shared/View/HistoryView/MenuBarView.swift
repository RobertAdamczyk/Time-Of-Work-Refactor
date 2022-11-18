//
//  MenuBarView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 14.03.21.
//

import SwiftUI

struct MenuBarView: View {
    var date: FetchedResults<Dates>.Element?
    @EnvironmentObject var viewModel: HistoryViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        if viewModel.selectedDate == date {
            HStack {
                Spacer()
                Button {
                    mainViewModel.activeSheet = .editDate
                } label: {
                    Text("Edit")
                        .padding(6)
                        .frame(width: 80)
                        .background(Color.theme.accent.opacity(0.9).cornerRadius(10))
                }
                Button {
                    if let date = date {
                        viewModel.removeDate(date: date, context: viewContext)
                    }
                } label: {
                    Text("Delete")
                        .padding(6)
                        .frame(width: 80)
                        .background(Color.theme.red.opacity(0.9).cornerRadius(10))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .transition(.move(edge: .trailing))
            .padding(.horizontal, 5)
        } else {
            EmptyView()
        }
    }
}
