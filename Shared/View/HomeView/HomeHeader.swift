//
//  HeaderView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct HomeHeader: View {
    var value : String
    var body: some View {
        HStack{
            Text("\(value)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("Orange"))
                .padding(.leading, 5)
            Spacer()
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(10)
        .backgroundWithBorder
        .padding(.horizontal,-1)
        .padding(.top,-1)
    }
}
