//
//  DateRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 05.03.21.
//

import SwiftUI

struct NewDateRow: View {
    @EnvironmentObject var viewModel: AddDateViewModel
    var body: some View {
        Button(action:{
                viewModel.changeShowComponent(newValue: .datePicker)
        }){
            HStack{
                Text("Date").bold()
                    .foregroundColor(.gray)
                Spacer()
                HStack{
                    if viewModel.new.night {
                        Image(systemName: "moon.stars.fill")
                    }
                    Text("\(viewModel.new.date, style: .date)").bold()       
                }
                .foregroundColor(Color("Orange"))
            }
            .padding()
            .roundedBackgroundWithBorder
            
        }
    }

}
