//
//  DateRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct DateRow: View {
    var body: some View {
        HStack {
            Spacer()
            Text("\(Date(), style: .date)")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color("Orange"))
            Spacer()
        }
        .padding(.vertical)
        .roundedBackgroundWithBorder
        .padding()
    }
}

struct DateRow_Previews: PreviewProvider {
    static var previews: some View {
        DateRow()
    }
}
