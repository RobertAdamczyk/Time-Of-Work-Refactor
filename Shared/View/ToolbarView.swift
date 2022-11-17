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
        ZStack(alignment: .top){
            VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
                .frame(width: UIScreen.main.bounds.width, height: 85 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0))
                .clipShape(CustomToolbar(radius: 35))
                .overlay(CustomToolbar(radius: 35).stroke(Color("BorderColor")).padding(.horizontal,-1).padding(.bottom,-1))
            HStack{
                Spacer()
                
                Button(action: { viewModel.view = .home }){
                    VStack{
                        Image(systemName: "square.grid.2x2")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Home")
                            .font(.system(size: 10))
                    }
                    .frame(width: 50)
                    .padding(.top, 40)
                    .foregroundColor(viewModel.view == .home ? Color("Orange") : Color.gray)
                    
                }
                
                Spacer()
                
                Button(action: { viewModel.activeSheet = .addDate }){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .foregroundColor(Color("Orange"))
                .offset(y: -5)
                
                Spacer()
                
                Button(action: { viewModel.view = .history }){
                    VStack{
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("History")
                            .font(.system(size: 10))
                    }
                    .frame(width: 50)
                    .padding(.top, 40)
                    .foregroundColor(viewModel.view == .history ? Color("Orange") : Color.gray)
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
