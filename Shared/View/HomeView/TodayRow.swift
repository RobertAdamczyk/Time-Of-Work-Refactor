//
//  HomeViewRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct TodayRow: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @AppStorage("working") var working = false
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("TODAY")
                .font(.system(size: 12))
                .foregroundColor(Color.gray.opacity(0.8))
                .padding(.leading)
            HStack{
                Spacer()
                Text("Work: \(working ? viewModel.currentTime.toTimeString() : "--:--")")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Orange"))
                    .frame(width: 120)
                Text("Pause: \(working ? viewModel.pause.toTimeString() : "--:--")")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Orange"))
                    .frame(width: 120)
                    .onChange(of: viewModel.pause) { _ in
                        viewModel.currentTime = viewModel.currentWorkTime()
                    }
                Spacer()
            }
            .padding()
            .roundedBackgroundWithBorder
        }
        .padding()
        .onReceive(viewModel.timer) { _ in
            viewModel.currentTime = viewModel.currentWorkTime()
        }
    }
}

struct TodayRow_Previews: PreviewProvider {
    static var previews: some View {
        TodayRow()
    }
}
