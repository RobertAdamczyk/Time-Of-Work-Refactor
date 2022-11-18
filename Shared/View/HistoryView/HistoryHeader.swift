//
//  HistoryHeader.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 04.03.21.
//

import SwiftUI

struct HistoryHeader: View {
    @Binding var show: Bool
    var body: some View {
        HStack {
            if !show {
                HStack {
                    Text("History")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Orange"))
                        .padding(.leading, 5)
                    Spacer()
                }
            } else {
                HStack {
                    Spacer()
                    Text("History").bold()
                        .foregroundColor(Color("Orange"))
                    Spacer()
                }
            }
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(10)
        .backgroundWithBorder
        .padding(.horizontal, -1)
        .padding(.top, -1)
    }
}
