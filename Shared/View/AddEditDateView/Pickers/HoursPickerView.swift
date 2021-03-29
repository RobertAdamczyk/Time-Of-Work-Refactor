//
//  HoursPickerView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.03.21.
//

import SwiftUI

struct HoursPickerView: View {
    @Binding var value: Int
    var body: some View {
        VStack{
            Picker("", selection: $value){
                ForEach(0..<11, id: \.self) { i in
                    Text("\(i)")
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width-20)
        .backgroundWithBorder
    }
}
