//
//  HomeViewRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct NowRow: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var setting: SettingsViewModel

    var body: some View {
        VStack(spacing: 40) {
            Text("NOW")
                .font(.system(size: 12))
                .foregroundColor(Color.theme.gray.opacity(0.8))
            ZStack(alignment: .top) {
                HStack {
                    VStack {
                        Text("Pause:")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.accent)
                        Text("\(viewModel.pause.toTimeString())")
                    }
                    .onChange(of: viewModel.pause) { _ in
                       viewModel.refreshWorkTime()
                    }
                    Spacer()
                    VStack {
                        Text("Start:")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.accent)
                        Text("\(viewModel.lastDate, style: .time)")
                    }
                    .onChange(of: viewModel.lastDate) { _ in
                        viewModel.refreshWorkTime()
                    }
                }
                ProgressCircleView(progress: viewModel.working ? CGFloat(viewModel.currentWorkTimeInSec) / CGFloat( 3600 * setting.hoursWeek / setting.daysWeek ) : 0)
                    .frame(width: Config.screenHeight * 0.18, height: Config.screenHeight * 0.18)
                    .overlay(
                        VStack {
                            Text("Work:")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.accent)
                            Text("\(viewModel.currentWorkTimeInSec.toTimeString())")
                        }.offset(y: -5)
                    )
                    .overlay(LoadingView()
                                .frame(width: Config.screenHeight * 0.12, height: Config.screenHeight * 0.12))
            }
        }
        .padding()
        .onReceive(viewModel.timer) { _ in
            viewModel.refreshWorkTime()
        }
        .onAppear {
            viewModel.refreshWorkTime()
            viewModel.checkCurrentWork()
        }
    }
}

struct NowRow_Previews: PreviewProvider {
    static var previews: some View {
        NowRow()
    }
}
