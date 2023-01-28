//
//  ToolbarView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct ToolbarView: View {
    @EnvironmentObject var viewModel: MainViewModel
    var body: some View {
        ZStack(alignment: .top) {
            VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
                .frame(width: Config.screenWidth,
                       height: 85 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0))
                .clipShape(CustomToolbar(radius: 35))
                .overlay(
                    CustomToolbar(radius: 35)
                        .stroke(Color.theme.border)
                        .padding(.horizontal, -1)
                        .padding(.bottom, -1)
                )
            HStack {
                Spacer()
                Button {
                    viewModel.view = .home
                    Analytics.logFirebaseClickEvent(.homeToolbar)
                } label: {
                    VStack {
                        ImageStore.square2x2.image
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(localized(string: "generic_home"))
                            .font(.system(size: 10))
                    }
                    .frame(width: 100)
                    .padding(.top, 40)
                    .foregroundColor(viewModel.view == .home ? Color.theme.accent : Color.theme.gray)
                }
                Spacer()
                Button {
                    viewModel.activeSheet = .addDate
                    Analytics.logFirebaseClickEvent(.addDateToolbar)
                } label: {
                    ImageStore.plus.image
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .foregroundColor(Color.theme.accent)
                .offset(y: -5)
                Spacer()
                Button {
                    viewModel.view = .history
                    Analytics.logFirebaseClickEvent(.historyToolbar)
                } label: {
                    VStack {
                        ImageStore.calendar.image
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(localized(string: "generic_history"))
                            .font(.system(size: 10))
                    }
                    .frame(width: 100)
                    .padding(.top, 40)
                    .foregroundColor(viewModel.view == .history ? Color.theme.accent : Color.theme.gray)
                }
                Spacer()
            }
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
