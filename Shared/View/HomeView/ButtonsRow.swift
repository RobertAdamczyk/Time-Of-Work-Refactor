//
//  ButtonsRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct ButtonsRow: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var mainViewModel: MainViewModel

    var body: some View {
        HStack {
            Button {
                mainViewModel.showPicker(pickerType: .pause)
            } label: {
                Text("Set Pause")
                    .font(.caption)
                    .foregroundColor(Color.theme.buttonText)
                    .padding(-5)
            }
            Spacer()
            Button {
                mainViewModel.showPicker(pickerType: .timeIn)
            } label: {
                Text("New Start")
                    .font(.caption)
                    .foregroundColor(Color.theme.buttonText)
                    .padding(-5)
            }
        }
        .frame(maxWidth: 250)
        .buttonStyle(OrangeButtonStyle())
    }
}

struct ButtonsRow_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsRow()
    }
}
