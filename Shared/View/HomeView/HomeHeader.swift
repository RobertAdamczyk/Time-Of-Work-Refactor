//
//  HeaderView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct HomeHeader: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    var value: String
    @State var animation = false
    var body: some View {
        HStack {
            Text("\(value)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
                .padding(.leading, 5)
            Spacer()
            Button {
                withAnimation {
                    mainViewModel.activeSheet = .settings
                }
            } label: {
                Image.store.gearshape
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.accent)
                    .rotationEffect(.init(degrees: animation ? 0 : -360))
                    .shadow(color: Color.theme.shadow, radius: 1, x: 1, y: 1)
            }
            .padding(.trailing, 10)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(10)
        .backgroundWithBorder
        .padding(.horizontal, -1)
        .padding(.top, -1)
        .onAppear {
            withAnimation(Animation.linear(duration: 9).repeatForever(autoreverses: false)) {
                animation.toggle()
            }
        }
    }
}
