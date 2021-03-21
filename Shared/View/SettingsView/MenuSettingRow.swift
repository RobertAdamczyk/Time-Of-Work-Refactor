//
//  MenuSettingRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

struct MenuSettingRow: View {
    var name: String
    var body: some View {
        HStack{
            Text("\(name)")
                .foregroundColor(Color("Orange"))
                .font(.title3)
                
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Orange"))
                .font(.title3)
        }
        .padding()
        .roundedBackgroundWithBorder
    }
}
