//
//  SettingHeaderView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.03.21.
//

import SwiftUI

struct SettingHeaderView: View {
    var name: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {

        HStack {
            Spacer()
            Text("\(name)").bold()
                .font(.title2)
                .foregroundColor(Color.theme.accent)
            Spacer()
        }
        .overlay(
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image.store.chevronBackward
                        Spacer()
                    }
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.theme.accent)
                    .frame(width: 60, height: 50)
                }
                Spacer()
            }
        )
        .padding(20)
        .backgroundWithBottom
    }
}
