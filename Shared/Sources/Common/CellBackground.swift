//
//  CellBackground.swift
//  Time Of Work
//
//  Created by Robert Adamczyk on 22.02.24.
//

import SwiftUI

fileprivate struct CellBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay {
                LinearGradient(gradient: Gradient(colors: [.init(red: 39/255,
                                                                 green: 39/255,
                                                                 blue: 39/255),
                                                           .init(red: 46/255,
                                                                 green: 46/255,
                                                                 blue: 46/255)]),
                               startPoint: .bottom, endPoint: .top)
                .overlay {
                    RoundedRectangle(cornerSize: CellConfig.cornerSize)
                        .stroke(lineWidth: 4)
                        .fill(LinearGradient(gradient: Gradient(colors: [.init(red: 39/255,
                                                                               green: 39/255,
                                                                               blue: 39/255),
                                                                         .init(red: 70/255,
                                                                               green: 70/255,
                                                                               blue: 70/255)]),
                                             startPoint: .bottom, endPoint: .top))
                }
            }
            .clipShape(RoundedRectangle(cornerSize: CellConfig.cornerSize))
    }
}

extension View {
    func applyCellBackground() -> some View {
        modifier(CellBackground())
    }
}
