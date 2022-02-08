//
//  PausePickerView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 13.03.21.
//

import SwiftUI

struct PausePickerView: View {
    @Binding var sec: Int
    @State var value1: Int = 0
    @State var value2: Int = 0
    var body: some View {
        GeometryReader { reader in
            HStack(spacing: 0){
                
                Picker("h", selection: $value1) {
                    ForEach(0...23, id: \.self) { i in
                        Text("\(i) h")
                    }
                    
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/2, height: reader.size.height)
                .compositingGroup()
                .clipped()
                Picker("h", selection: $value2) {
                    ForEach(0...59, id: \.self) { i in
                        Text("\(i) m")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: reader.size.width/2, height: reader.size.height)
                .compositingGroup()
                .clipped()
            }
            .onChange(of: value1) { _ in
                self.sec = value1 * 3600 + value2 * 60
            }
            .onChange(of: value2) { _ in
                self.sec = value1 * 3600 + value2 * 60
            }
            .onAppear(){
                value1 = self.sec / 3600
                value2 = self.sec % 3600 / 60
            }
        }
        .frame(height: 220)
        .backgroundWithBorder
        
    }
}
