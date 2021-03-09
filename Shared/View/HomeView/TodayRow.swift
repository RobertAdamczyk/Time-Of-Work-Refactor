//
//  HomeViewRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct TodayRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("TODAY")
                .font(.system(size: 12))
                .foregroundColor(Color.gray.opacity(0.8))
                .padding(.leading)
            HStack{
                Spacer()
                Text("Work: --:--")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Orange"))
                    .frame(width: 120)
                Text("Pause: --:--")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Orange"))
                    .frame(width: 120)
                Spacer()
            }
            .padding()
            .roundedBackgroundWithBorder
        }
        .padding()
    }
}

struct TodayRow_Previews: PreviewProvider {
    static var previews: some View {
        TodayRow()
    }
}
