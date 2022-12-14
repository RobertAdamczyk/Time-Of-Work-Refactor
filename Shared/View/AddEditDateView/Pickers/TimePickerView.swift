//
//  TimePickerView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var time: Date
    var body: some View {
        VStack{
            DatePicker("Start time: ", selection: $time, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .backgroundWithBorder
        }
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(time: .constant(Date()))
    }
}
