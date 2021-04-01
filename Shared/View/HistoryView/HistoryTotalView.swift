//
//  HistoryTotalView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 30.03.21.
//

import SwiftUI

struct HistoryTotalView: View {
    let item: SumOfWeek
    var body: some View {
        HStack(spacing: 15){
            Text("Total:")
                .foregroundColor(.gray)
            VStack{
                HStack{
                    Image(systemName: "hammer.fill")
                        .foregroundColor(.gray)
                    Text("\(item.secWork.toTimeString())")
                        .bold()
                    Image(systemName: "pause.circle")
                        .foregroundColor(.gray)
                    Text("\(item.secPause.toTimeString())")
                        .bold()
                }
                .foregroundColor(Color("Orange"))
                HStack{
                    if item.holidays > 0 {
                        Image(systemName: "case.fill")
                            .foregroundColor(.gray)
                        Text("\(item.holidays) d")
                            .bold()
                        Spacer().frame(width: 20)
                    }
                    
                    
                    if item.publicHolidays > 0 {
                        Image(systemName: "flag.fill")
                            .foregroundColor(.gray)
                        Text("\(item.publicHolidays) d")
                            .bold()
                        Spacer().frame(width: 20)
                    }
                    
                    
                    if item.sickness > 0 {
                        Image(systemName: "bandage.fill")
                            .foregroundColor(.gray)
                        Text("\(item.sickness) d")
                            .bold()
                    }
                    
                }
                .foregroundColor(Color("Orange"))
                
                
            }
        }
    }
}
