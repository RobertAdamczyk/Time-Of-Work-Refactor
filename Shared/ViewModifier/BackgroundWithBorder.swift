//
//  BackgroundWithBorder.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import Foundation
import SwiftUI

extension View {
    var backgroundWithBorder: some View {
        self
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial)))
            .border(Color("BorderColor"))
    }
    
    var backgroundWithBottom: some View {
        self
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial)))
            .overlay(
                VStack{
                    Spacer()
                    Rectangle().frame(height: 1)
                        .foregroundColor(Color("BorderColor"))
                }
            )
    }
    
    var backgroundWithBottomTop: some View {
        self
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial)))
            .overlay(
                VStack{
                    Rectangle().frame(height: 1)
                    Spacer()
                    Rectangle().frame(height: 1)
                }
                .foregroundColor(Color("BorderColor"))
            )
    }
    
    var roundedBackgroundWithBorder: some View {
        self
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
                            .clipShape(RoundedRectangle(cornerRadius: 15)))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("BorderColor")))
    }
}
