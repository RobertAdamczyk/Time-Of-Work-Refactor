//
//  ButtonsRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct ButtonsRow: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager

    var body: some View {
        HStack {
            Button {
                if viewModel.working {
                    let newDate = viewModel.createNewRecordForEndWork()
                    coreDataManager.addDate(for: newDate)
                }
                viewModel.setLastDate(value: Date())
                viewModel.refreshWorkTime()
                viewModel.toggleWorking()
            } label: {
                Text(viewModel.working ? "End Work" : "Start Work")
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.buttonText)
                    .frame(width: 100)
            }

            Spacer()
            Button {
                viewModel.changeShowComponent(newValue: .pausePicker)
            } label: {
                Text("Set Pause")
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.buttonText)
                    .frame(width: 100)
            }

        }
        .buttonStyle(OrangeButtonStyle())
        .padding(.vertical, viewModel.padding)
        .padding(.horizontal, 40)
    }
}

struct ButtonsRow_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsRow()
    }
}
