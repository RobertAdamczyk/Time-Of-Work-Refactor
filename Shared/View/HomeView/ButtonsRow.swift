//
//  ButtonsRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct ButtonsRow: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        HStack {
            Button {
                if viewModel.working {
                    viewModel.endWork(context: viewContext)
                }
                viewModel.setLastDate(value: Date())
                viewModel.refreshWorkTime()
                viewModel.toggleWorking()
            } label: {
                Text(viewModel.working ? "End Work" : "Start Work")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 100)
            }

            Spacer()
            Button {
                viewModel.changeShowComponent(newValue: .pausePicker)
            } label: {
                Text("Set Pause")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
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
