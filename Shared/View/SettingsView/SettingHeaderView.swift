//
//  SettingHeaderView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.03.21.
//

import SwiftUI

struct SettingHeaderView: View {
    var name: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        
        HStack {
            Spacer()
            Text("\(name)").bold()
                .font(.title2)
                .foregroundColor(Color("Orange"))
            Spacer()
        }
        .overlay(
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    HStack{
                        Image(systemName: "chevron.backward")
                        Spacer()
                    }
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color("Orange"))
                    .frame(width: 60, height: 50)
                }
                
                Spacer()
            }
        )
        .padding(20)
        .backgroundWithBorder
        .padding(.horizontal, -1)
        .padding(.top, -1)
    }
}
