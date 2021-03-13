//
//  HistoryRow.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import SwiftUI

struct HistoryRow: View {
    var value : FetchedResults<Dates>.Element
    var width = UIScreen.main.bounds.width * 0.25
    var body: some View {
        HStack(spacing: 0){
            Rectangle()
                .frame(width: 2)
                .padding(.vertical, 3)
                .foregroundColor(Color("Orange"))
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
            
            .frame(width: width)
            Spacer()
            VStack{
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
            .frame(width: width)
            Spacer()
            HStack{
                VStack{
                    Text("\(value.secWork.toTimeString())")
                    Text("\(value.secPause.toTimeString())")
                }
                VStack{
                    Image(systemName: "hammer.fill")
                    Image(systemName: "pause.circle")
                }
                .foregroundColor(.gray)
            }
            .frame(width: width+5)
            
        }
        .padding(.horizontal)
        .padding(.vertical, 3)
    }
  
}


struct Example {
    var secWork = 43513
    var secPause = 431413
    var timeIn = Date()
    var timeOut = Date()
    var date = Date()
    var night = true
    static var example = Example()
}
