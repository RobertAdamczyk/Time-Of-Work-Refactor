//
//  ProgressCircleView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 13.03.21.
//

import SwiftUI

struct ProgressCircleView: View {

    @EnvironmentObject var viewModel: HomeViewModel

    @State var progressAnimation: CGFloat = 0

    @AppStorage(Storable.hoursDaySetting.key) private var hoursDaySetting: Double = 8

    var body: some View {
        GeometryReader { reader in
            ZStack {
                Circle()
                    .stroke(Color.theme.shadow, lineWidth: reader.size.width/10)
                    .frame(width: reader.size.width, height: reader.size.height)
                Circle()
                    .rotation(.init(degrees: -90))
                    .trim(from: 0, to: progressAnimation)
                    .stroke(Color.theme.accent, style: StrokeStyle(lineWidth: reader.size.width/10, lineCap: .round))
                    .frame(width: reader.size.width, height: reader.size.height)
            }
        }
        .animation(Animation.spring(response: 1, dampingFraction: 1, blendDuration: 1).speed(0.3),
                   value: progressAnimation)
        .onChange(of: viewModel.currentWorkTimeInSec) { newValue in
            setProgress(new: CGFloat(newValue) / CGFloat( 3600 * hoursDaySetting ))
        }
    }

    func setProgress(new: CGFloat) {
        progressAnimation = viewModel.working ? new : 0
    }
}
