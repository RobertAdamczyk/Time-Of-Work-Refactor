//
//  SaveButtonRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 06.03.21.
//

import SwiftUI

struct SaveButtonRow: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    @Environment(\.managedObjectContext) var viewContext
    @Binding var activeSheet: SheetView?
    var date: FetchedResults<Dates>.Element?

    var body: some View {
        Button {
            if let date = date {
                viewModel.editDate(date: date, context: viewContext)
            } else {
                viewModel.addDate(context: viewContext)
            }
            NotificationCenter.default.post(Notification(name: Notification.Name("RefreshHistory")))
            activeSheet = nil
        } label: {
            Text("Save")
                .fontWeight(.bold)
                .foregroundColor(Color.theme.buttonText)
                .frame(width: 100)
        }
        .buttonStyle(OrangeButtonStyle())
    }
}
