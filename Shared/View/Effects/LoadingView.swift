//
//  LoadingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 18.03.21.
//

import SwiftUI

struct LoadingView: View {
    @State var startAnimation: [Bool] = [false, false, false]
    @State var offset: [CGFloat] = [1, 0, -1]
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Color.clear
                ForEach(0..<3) { index in
                    Circle()
                        .frame(width: reader.size.width/10, height: reader.size.height/10)
                        .foregroundColor(Color("Orange"))
                        .offset(x: reader.size.width/4 * offset[index], y: reader.size.height/2 * -1)
                        .rotationEffect(.init(degrees: startAnimation[index] ? 0 : -360))
                }
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .onAppear {
                let delay: Double = 0.5
                let nextDelay: Double = 0.3
                for index in startAnimation.indices {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + Double(index) * nextDelay) {
                        withAnimation(Animation.spring(response: 1,
                                                       dampingFraction: 1,
                                                       blendDuration: 0)
                            .speed(0.6)
                            .repeatForever(autoreverses: false)) {
                                startAnimation[index] = true
                        }
                    }
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
