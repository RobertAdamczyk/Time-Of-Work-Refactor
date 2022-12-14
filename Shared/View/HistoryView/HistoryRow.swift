//
//  HistoryRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import SwiftUI

struct HistoryRow: View {
    var value : FetchedResults<Dates>.Element
    var width = UIScreen.main.bounds.width * 0.27
    var body: some View {
        HStack(spacing: 0){
            HStack{
                VStack{
                    
                    if value.night {
                        Text("\(value.date.toString(format: .dayOnlyShort))-\(value.date.plusOneDay()!.toString(format: .dayOnlyShort))")
                        Text("\(value.date.toString(format: .dayOnlyNumber))-\(value.date.plusOneDay()!.toString(format: .shortDate))")
                    }else{
                        Text("\(value.date.toString(format: .dayOnly))")
                        Text("\(value.date.toString(format: .shortDate))")
                    }
                }
            }
            .frame(width: width-5)
            Spacer()
            
            if value.specialDay == nil {
                VStack(alignment: .trailing){
                    HStack{
                        
                        Text("\(value.timeIn, style: .time)")
                        Image(systemName: "arrowshape.turn.up.left.fill")
                            .foregroundColor(.green)
                    }
                    HStack{
                        
                        Text("\(value.timeOut, style: .time)")
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .foregroundColor(.red)
                    }
                }
                .frame(width: width+5)
            }else {
                HistorySpecialDayView(value: value)
                    .frame(width: width+5)
            }
            
            Spacer()
            HStack{
                VStack{
                    Text("\(value.secWork.toTimeString())")
                    if value.specialDay == nil { Text("\(value.secPause.toTimeString())") }
                }
                VStack{
                    Image(systemName: "hammer.fill")
                    if value.specialDay == nil { Image(systemName: "pause.circle") }
                }
                .foregroundColor(.gray)
            }
            .frame(width: width+5)
            
        }
        .overlay(
            HStack{
                Rectangle()
                    .frame(width: 2)
                    .padding(.vertical, 3)
                    .foregroundColor(Color("Orange"))
                    .padding(.leading, 3)
                Spacer()
            }
        )
        .padding(.horizontal, 5)
        .padding(.vertical, 3)
        
    }
  
}
