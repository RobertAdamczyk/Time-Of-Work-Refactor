//
//  ProgressCircleView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 13.03.21.
//

import SwiftUI

struct ProgressCircleView: View {
    @State var progressAnimation: CGFloat = 0
    var progress: CGFloat
    var body: some View {
        GeometryReader { reader in
            ZStack{
                Circle()
                    .stroke(Color.gray, lineWidth: reader.size.width/10)
                    .frame(width: reader.size.width, height: reader.size.height)
                Circle()
                    .rotation(.init(degrees: -90))
                    .trim(from: 0, to: progressAnimation)
                    .stroke(Color("Orange"), style: StrokeStyle(lineWidth: reader.size.width/10, lineCap: .round))
                    .frame(width: reader.size.width, height: reader.size.height)
            }
        }.onAppear() {
            setProgress(new: progress)
        }
        .onChange(of: progress) { new in
            setProgress(new: new)
        }
        
    }
    
    func setProgress(new: CGFloat) {
        withAnimation(Animation.spring(response: 1, dampingFraction: 1, blendDuration: 1).speed(0.3).delay(0.5)){
            progressAnimation = new
            print("onChange \(new)")
        }
    }
}
struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progress: 0.1)
    }
}
