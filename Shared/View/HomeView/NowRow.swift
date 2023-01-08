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
    @EnvironmentObject var mainViewModel: MainViewModel
    var body: some View {
        VStack(spacing: 40) {
            Text(localized(string: "generic_now"))
                .font(.system(size: 12))
                .foregroundColor(Color.theme.gray.opacity(0.8))
            ZStack(alignment: .top) {
                HStack {
                    VStack {
                        Text("\(localized(string: "generic_pause")):")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.accent)
                        Text("\((viewModel.pauseTimeInSec+viewModel.currentPauseTimeInSec).toTimeStringTimerFormat())")
                    }
                    .onTapGesture {
                        guard !viewModel.isPauseOn else { return }
                        mainViewModel.showPicker(pickerType: .pause)
                    }
                    Spacer()
                    VStack {
                        Text("\(localized(string: "generic_start")):")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.accent)
                        Text("\(viewModel.lastDateForWork, style: .time)")
                    }
                    .onTapGesture {
                        mainViewModel.showPicker(pickerType: .timeIn)
                    }
                }
                ProgressCircleView(progress: viewModel.working ? CGFloat(viewModel.currentWorkTimeInSec) / CGFloat( 3600 * setting.hoursDaySetting ) : 0)
                    .frame(width: Config.screenHeight * 0.18, height: Config.screenHeight * 0.18)
                    .overlay(
                        VStack {
                            Text("\(localized(string: "generic_work")):")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.accent)
                            Text("\(viewModel.currentWorkTimeInSec.toTimeStringTimerFormat())")
                            ZStack {
                                HammerAnimation()
                                    .opacity(viewModel.isPauseOn ? 0 : 1)
                                Image.store.pauseCircle
                                    .foregroundColor(Color.theme.gray)
                                    .opacity(viewModel.isPauseOn ? 1 : 0)
                            }
                        }
                    )
            }
        }
        .padding()
        .onReceive(viewModel.timer) { _ in
            guard mainViewModel.activeSheet == nil && mainViewModel.showPickerType == nil &&
                  mainViewModel.showMenu == false else { return }
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

struct HammerAnimation: View {
    @State var startAnimation: Bool = false
    var body: some View {
        Image.store.hammer
            .foregroundColor(Color.theme.gray)
            .rotationEffect(Angle(degrees: startAnimation ? 15 : 0), anchor: .bottomLeading)
            .animation(.default.repeatForever(), value: startAnimation)
            .onAppear {
                startAnimation.toggle()
            }
    }
}
