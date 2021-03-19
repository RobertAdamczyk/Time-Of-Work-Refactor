//
//  LoadingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 18.03.21.
//

import SwiftUI

import SwiftUI

struct LoadingView: View {
    @State var startAnimation: [Bool] = [false, false, false]
    @State var offset: [CGFloat] = [1, 0 , -1]
    var body: some View {
        GeometryReader { reader in
            ZStack{
                Color.clear
                ForEach(0..<3) { i in
                    Circle()
                        .frame(width: reader.size.width/10, height: reader.size.height/10)
                        .foregroundColor(Color("Orange"))
                        .offset(x: reader.size.width/4 * offset[i], y: reader.size.height/2 * -1)
                        .rotationEffect(.init(degrees: startAnimation[i] ? 0 : -360))
                }
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .onAppear(){
                let delay: Double = 0.5
                let nextDelay: Double = 0.3
                for i in startAnimation.indices {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + Double(i) * nextDelay) {
                        withAnimation(Animation.spring(response: 1, dampingFraction: 1, blendDuration: 0).speed(0.6).repeatForever(autoreverses: false)){
                            startAnimation[i] = true
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
