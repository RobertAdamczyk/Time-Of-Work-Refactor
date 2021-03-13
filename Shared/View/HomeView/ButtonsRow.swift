//
//  ButtonsRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 03.03.21.
//

import SwiftUI

struct ButtonsRow: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @AppStorage("working") var working: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        HStack{
            Button(action:{
                
                if working {
                    viewModel.endWork(context: viewContext)
                }
                viewModel.setLastDate(value: Date())
                viewModel.currentTime = viewModel.currentWorkTime()
                withAnimation{
                    working.toggle()
                }
               
            }){
                Text(working ? "End Work" : "Start Work")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 100)
            }
                
            Spacer()
            Button(action:{
                withAnimation{
                    viewModel.showPausePicker.toggle()
                }
            }){
                Text("Set Pause")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 100)
            }
            
        }
        .buttonStyle(OrangeButtonStyle())
        .padding(.vertical)
        .padding(.horizontal, 40)
    }
}

struct ButtonsRow_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsRow()
    }
}
