//
//  DatePickerView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 04.03.21.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    @Binding var night: Bool
    var body: some View {
        
        VStack{
            DatePicker("Start time: ", selection: $date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
            Divider()
            HStack{
                Toggle(isOn: $night){
                    Text("Work at night ?")
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .frame(width: UIScreen.main.bounds.width-20)
        .backgroundWithBorder
    }
}


