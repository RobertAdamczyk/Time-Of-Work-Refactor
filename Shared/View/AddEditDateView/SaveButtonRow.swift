//
//  SaveButtonRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 06.03.21.
//

import SwiftUI

struct SaveButtonRow: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Binding var activeSheet: SheetView?
    var date: Dates?

    var body: some View {
        Button {
            if let date = date {
                coreDataManager.removeDate(date: date)
                coreDataManager.addDate(for: viewModel.new)
            } else {
                coreDataManager.addDate(for: viewModel.new)
            }
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
