//
//  CustomToolbar.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 02.03.21.
//

import SwiftUI

struct CustomToolbar: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        // let radius = CGFloat(35)//rect.height/3
        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY + radius),
                    radius: radius, startAngle: .zero,
                    endAngle: .init(degrees: 180), clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + radius))
        path.closeSubpath()
        return path
    }
}
