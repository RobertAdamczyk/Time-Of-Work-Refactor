//
//  LoadingView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 18.03.21.
//

import SwiftUI

import SwiftUI

struct LoadingView: View {
    @State var startAnimation = false
    @State var startAnimation2 = false
    @State var startAnimation3 = false
    
    var body: some View {
        GeometryReader { reader in
            ZStack{
                Color.clear
                Circle()
                    .frame(width: reader.size.width/10, height: reader.size.height/10)
                    .foregroundColor(Color("Orange"))
                    .offset(x: reader.size.width/4 * 1, y: reader.size.height/2 * -1)
                    .rotationEffect(.init(degrees: startAnimation ? 0 : -360))
                Circle()
                    .frame(width: reader.size.width/10, height: reader.size.height/10)
                    .foregroundColor(Color("Orange"))
                    .offset(y: reader.size.height/2 * -1)
                    .rotationEffect(.init(degrees: startAnimation2 ? 0 : -360))
                Circle()
                    .frame(width: reader.size.width/10, height: reader.size.height/10)
                    .foregroundColor(Color("Orange"))
                    .offset(x: reader.size.width/4 * -1,y: reader.size.height/2 * -1)
                    .rotationEffect(.init(degrees: startAnimation3 ? 0 : -360))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(Animation.spring(response: 1, dampingFraction: 1, blendDuration: 0).speed(0.6).repeatForever(autoreverses: false)){
                        startAnimation = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(Animation.spring(response: 1, dampingFraction: 1, blendDuration: 0).speed(0.6).repeatForever(autoreverses: false)){
                        startAnimation2 = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    withAnimation(Animation.spring(response: 1, dampingFraction: 1, blendDuration: 0).speed(0.6).repeatForever(autoreverses: false)){
                        startAnimation3 = true
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
