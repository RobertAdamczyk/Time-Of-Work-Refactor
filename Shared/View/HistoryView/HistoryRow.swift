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
        HStack{
            Rectangle()
                .frame(width: 2)
                .padding(.vertical, 3)
                .foregroundColor(Color("Orange"))
            
            VStack{
                Text("\(value.date.toString(format: .dayOnly))")
                Text("\(value.date.toString(format: .shortDate))")
            }
            .frame(width: width)
            Spacer()
            VStack{
                HStack{
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .foregroundColor(.green)
                    Text("\(value.timeIn, style: .time)")
                }
                HStack{
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .foregroundColor(.red)
                    Text("\(value.timeOut, style: .time)")
                }
            }
            .frame(width: width)
            Spacer()
            VStack{
                HStack{
                    Spacer()
                    Image(systemName: "hammer.fill")
                        .frame(width: 20)
                        .foregroundColor(.gray)
                    
                    Text("\(value.secWork.toTimeString())")
                        .frame(width: 65)
                }
                HStack{
                    Spacer()
                    Image(systemName: "pause.circle")
                        .frame(width: 20)
                        .foregroundColor(.gray)
                    
                    Text("\(value.pause.toString(format: .shortTime))")
                        .frame(width: 65)
                }
                
            }
            .frame(width: width)
            
        }
        .padding(.horizontal)
        .padding(.vertical, 3)
    }
  
}

struct HistoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

