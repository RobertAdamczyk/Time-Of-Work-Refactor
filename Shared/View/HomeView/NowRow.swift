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
    @AppStorage("working") var working = false

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("NOW")
                .font(.system(size: 12))
                .foregroundColor(Color.gray.opacity(0.8))
                .padding(.leading)
            ZStack(alignment: .top) {
                HStack {
                    VStack {
                        Text("Pause:")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Orange"))
                        Text("\(working ? viewModel.pause.toTimeString() : "--:--")")
                    }
                    .onChange(of: viewModel.pause) { _ in
                       viewModel.refreshWorkTime()
                    }
                    Spacer()
                    VStack {
                        Text("Start:")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Orange"))
                        Text("\(viewModel.lastDate, style: .time)")
                    }
                }
                ProgressCircleView(progress: viewModel.working ? CGFloat(viewModel.currentTime) / CGFloat( 3600 * setting.hoursWeek / setting.daysWeek ) : 0)
                    .frame(width: viewModel.height * 0.18, height: viewModel.height * 0.18)
                    .overlay(
                        VStack {
                            Text("Work:")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Orange"))
                            Text("\(working ? viewModel.currentTime.toTimeString() : "--:--")")
                        }.offset(y: -5)
                    )
                    .overlay(LoadingView()
                                .frame(width: viewModel.height * 0.12, height: viewModel.height * 0.12))
            }
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.changeShowComponent(newValue: .timeInPicker)
                        } label: {
                            Text("New Start")
                                .fontWeight(.semibold)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(-5)
                        }
                        .buttonStyle(OrangeButtonStyle())
                    }
                }
            )
            .padding()
            .roundedBackgroundWithBorder
        }
        .padding()
        .onReceive(viewModel.timer) { _ in
            if viewModel.showComponent == nil {
                viewModel.refreshWorkTime()
            }
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
