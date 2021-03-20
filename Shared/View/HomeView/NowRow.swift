//
//  HomeViewRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct NowRow: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @AppStorage("working") var working = false
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("NOW")
                .font(.system(size: 12))
                .foregroundColor(Color.gray.opacity(0.8))
                .padding(.leading)
            ZStack(alignment: .top){
                HStack{
                    Text("Pause: \n\(working ? viewModel.pause.toTimeString() : "--:--")")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Orange"))
                        .onChange(of: viewModel.pause) { _ in
                           viewModel.refreshWorkTime()
                        }
                    Spacer()
                    Text("Start: \n\(viewModel.lastDate, style: .time)")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Orange"))
                }
                
                ProgressCircleView(progress: viewModel.working ? CGFloat(viewModel.currentTime) / 3600 : 0)
                    .frame(width: 150, height: 150)
                    .overlay(Text("Work:\n\(working ? viewModel.currentTime.toTimeString() : "--:--")")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Orange"))
                                .frame(width: 120))
                    .overlay(LoadingView()
                                .frame(width: 100, height: 100))
                
            }
            .padding()
            .roundedBackgroundWithBorder
            
            
        }
        .padding()
        .onReceive(viewModel.timer) { _ in
            if !viewModel.showPausePicker{
                viewModel.refreshWorkTime()
            }
        }
        .onAppear(){
            viewModel.refreshWorkTime()
        }
    }
}

struct NowRow_Previews: PreviewProvider {
    static var previews: some View {
        NowRow()
    }
}
