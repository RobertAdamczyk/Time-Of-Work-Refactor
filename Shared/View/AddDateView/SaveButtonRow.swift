//
//  SaveButtonRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 06.03.21.
//

import SwiftUI

struct SaveButtonRow: View {
    @EnvironmentObject var viewModel: AddDateViewModel
    @Environment(\.managedObjectContext) var viewContext
    @Binding var showSheet: Bool
    var date: FetchedResults<Dates>.Element?
    
    var body: some View {
        Button(action:{
            if viewModel.werifyDates() {
                if let date = date {
                    viewModel.editDate(date: date, context: viewContext)
                }else {
                    viewModel.addDate(context: viewContext)
                }
                NotificationCenter.default.post(Notification(name: Notification.Name("RefreshHistory")))
                showSheet = false
            }
        }){
            Text("Save")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 100)
        }
        .buttonStyle(OrangeButtonStyle())
    }
}
