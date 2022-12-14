//
//  HeaderView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct HomeHeader: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    var value : String
    @State var animation = false
    var body: some View {
        HStack{
            Text("\(value)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("Orange"))
                .padding(.leading, 5)
            Spacer()
            
            Button(action:{
                withAnimation {
                    mainViewModel.activeSheet = .settings
                }
            }){
                Image(systemName: "gearshape.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color("Orange"))
                    .rotationEffect(.init(degrees: animation ? 0 : -360))
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
            }
            .padding(.trailing, 10)
                
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(10)
        .backgroundWithBorder
        .padding(.horizontal,-1)
        .padding(.top,-1)
        .onAppear(){
            withAnimation(Animation.linear(duration: 9).repeatForever(autoreverses: false)){
                animation.toggle()
            }
        }
    }
}
