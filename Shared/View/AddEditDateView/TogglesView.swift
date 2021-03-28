//
//  TogglesView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 28.03.21.
//

import SwiftUI

struct TogglesView: View {
    @EnvironmentObject var viewModel: AddEditDateViewModel
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("Holiday").bold()
                    .foregroundColor(.gray)
                Spacer()
                Toggle("", isOn: $viewModel.new.holiday)
            }
            .padding(10)
            .roundedBackgroundWithBorder
            
            HStack{
                Text("Public Holiday").bold()
                    .foregroundColor(.gray)
                Spacer()
                Toggle("", isOn: $viewModel.new.publicHoliday)
            }
            .padding(10)
            .roundedBackgroundWithBorder
            
            HStack{
                Text("Sickness").bold()
                    .foregroundColor(.gray)
                Spacer()
                Toggle("", isOn: $viewModel.new.sickness)
            }
            .padding(10)
            .roundedBackgroundWithBorder
            
            Spacer()
        }
        .toggleStyle(SwitchToggleStyle(tint: Color("Orange")))
        .onChange(of: viewModel.new.holiday) { new in
            if new {
                withAnimation{
                    viewModel.new.publicHoliday = false
                    viewModel.new.sickness = false
                }
            }
        }
        .onChange(of: viewModel.new.publicHoliday) { new in
            if new {
                withAnimation{
                    viewModel.new.holiday = false
                    viewModel.new.sickness = false
                }
                
            }
        }
        .onChange(of: viewModel.new.sickness) { new in
            if new {
                withAnimation{
                    viewModel.new.publicHoliday = false
                    viewModel.new.holiday = false
                }
            }
        }
    }
}
