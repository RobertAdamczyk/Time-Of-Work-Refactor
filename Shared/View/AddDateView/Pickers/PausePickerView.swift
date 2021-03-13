//
//  PausePickerView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 13.03.21.
//

import SwiftUI

struct PausePickerView: View {
    @Binding var date: Date
    @State var value1: Int = 0
    @State var value2: Int = 0
    
    init(date: Binding<Date>){
        self._date = date
        value1 = Calendar.current.component(.hour, from: self.date)
        value2 = Calendar.current.component(.minute, from: self.date)
    }
    var body: some View {
        GeometryReader { reader in
            HStack (spacing: 0){
                ZStack(alignment: Alignment.init(horizontal: .center, vertical: .center)){
                    HStack{
                        Text("hour").bold()
                            .offset(x: 45)
                    }
                    Picker("h", selection: $value1) {
                        ForEach(0...23, id: \.self) { i in
                            Text("\(i)")
                                .padding(.leading, 50)
                        }.offset(x: -115)
                        
                    }.offset(x: 100)
                }
                .frame(width: reader.size.width/2, height: reader.size.height)
                .clipped()
                ZStack(alignment: Alignment.init(horizontal: .center, vertical: .center)){
                    HStack{
                        Text("min").bold()
                            .offset(x: 7)
                    }
                    Picker("h", selection: $value2) {
                        ForEach(0...59, id: \.self) { i in
                            Text("\(i)")
                                .padding(.trailing, 50)
                        }.offset(x: 100)
                    }.offset(x: -100)
                }
                .frame(width: reader.size.width/2, height: reader.size.height)
                .clipped()
            }
            .onChange(of: value1) { _ in
                self.date = Calendar.current.date(bySettingHour: value1, minute: value2, second: 0, of: self.date)!
            }
            .onChange(of: value2) { _ in
                self.date = Calendar.current.date(bySettingHour: value1, minute: value2, second: 0, of: self.date)!
            }
        }
        .frame(width: UIScreen.main.bounds.width-20, height: 220)
        .backgroundWithBorder
        
    }
}
