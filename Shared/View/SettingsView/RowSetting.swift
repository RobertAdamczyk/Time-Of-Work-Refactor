//
//  MenuSettingRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//

import SwiftUI

struct RowSetting: View {
    var name: String
    var value: String?
    var body: some View {
        HStack(spacing: 20){
            Text("\(name)")
            Spacer()
            if value != nil { Text("\(value!)").foregroundColor(.gray) }
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Orange"))
        }
        .font(.system(size: 18, weight: .regular))
        .padding(.horizontal)
        .padding(.vertical, 14)
    }
}
