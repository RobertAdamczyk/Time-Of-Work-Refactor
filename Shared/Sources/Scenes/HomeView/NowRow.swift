//
//  HomeViewRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct NowRow: View {

    @EnvironmentObject var viewModel: HomeViewModel

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
                        viewModel.onPauseTapped()
                    }
                    Spacer()
                    VStack {
                        Text("\(localized(string: "generic_start")):")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.accent)
                        Text("\(viewModel.lastDateForWork, style: .time)")
                    }
                    .onTapGesture {
                        viewModel.onTimeInTapped()
                    }
                }
                ProgressCircleView()
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
                                ImageStore.pauseCircle.image
                                    .foregroundColor(Color.theme.gray)
                                    .opacity(viewModel.isPauseOn ? 1 : 0)
                            }
                        }
                    )
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

struct HammerAnimation: View {
    @State var startAnimation: Bool = false
    var body: some View {
        ImageStore.hammer.image
            .foregroundColor(Color.theme.gray)
            .rotationEffect(Angle(degrees: startAnimation ? 15 : 0), anchor: .bottomLeading)
            .animation(.default.repeatForever(), value: startAnimation)
            .onAppear {
                startAnimation.toggle()
            }
    }
}
