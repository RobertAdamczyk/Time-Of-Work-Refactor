//
//  HoursRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.03.21.
//

import SwiftUI

struct HoursRow: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    var body: some View {
        Button(action:{
            viewModel.changeShowComponent(newValue: .hoursPicker)
        }){
            HStack{
                Text("Hours").bold()
                    .foregroundColor(.gray)
                Spacer()
                Text("\(viewModel.hoursCount)").bold()
                    .foregroundColor(Color("Orange"))
            }
            .padding()
            .roundedBackgroundWithBorder
            
        }
    }
}
