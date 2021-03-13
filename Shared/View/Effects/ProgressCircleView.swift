//
//  ProgressCircleView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 13.03.21.
//

import SwiftUI

struct ProgressCircleView: View {
    var progress: CGFloat
    var body: some View {
        GeometryReader { reader in
            ZStack{
                Circle()
                    .stroke(Color.gray, lineWidth: reader.size.width/7)
                    .frame(width: reader.size.width, height: reader.size.height)
                Circle()
                    .rotation(.init(degrees: -90))
                    .trim(from: 0, to: progress)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: reader.size.width/7, lineCap: .round))
                    .frame(width: reader.size.width, height: reader.size.height)
            }
        }.frame(width: 250, height: 250)
        
    }
}
struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progress: 0.7)
    }
}
