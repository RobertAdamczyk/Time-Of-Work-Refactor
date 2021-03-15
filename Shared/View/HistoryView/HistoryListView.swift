//
//  HistoryListView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.03.21.
//

import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var viewModel: HistoryViewModel
    var result : FetchedResults<Dates>
    var body: some View {
        
        ForEach(viewModel.weeksAndYears, id: \.self) { item in
            VStack{
                HStack{
                    Text("\(item.weekOfYear)/\(String(item.yearForWeekOfYear))").bold()
                        .font(.title)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                VStack(spacing: 0){
                    Button(action:{
                        withAnimation {
                            viewModel.weeksAndYears[viewModel.weeksAndYears.firstIndex(of: item)!].showWeek.toggle()
                        }
                    }){
                        HStack{
                            Spacer()
                            Text("\(item.beginOfWeek, style: .date) -").bold()
                            Text("\(item.endOfWeek, style: .date)").bold()
                            Spacer()
                        }
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: false)
                        .foregroundColor(Color("Orange"))
                        .padding(.vertical, 10)
                    }
                    
                    if item.showWeek {
                        VStack(spacing: 0){
                            ForEach(result, id: \.self) { date in
                                if viewModel.dateIsEqualWeekAndYear(date: date.date, value: item) {
                                    Divider()
                                    HistoryRow(value: date)
                                        
                                        .contentShape(Rectangle())
                                        .onTapGesture{
                                            withAnimation{
                                                viewModel.selectedDate = viewModel.selectedDate == date ? nil : date
                                            }
                                        }
                                        .overlay(
                                            MenuBarView(date: date) // menu delete edit row of date
                                        )
                                }
                            }
                        }
                    }
                    Divider()
                    HStack{
                        Text("Total:")
                            .foregroundColor(.gray)
                        Image(systemName: "hammer.fill")
                            .foregroundColor(.gray)
                        Text("\(viewModel.weeklySum(array: result, week: item).work.toTimeString())")
                            .bold()
                        Image(systemName: "pause.circle")
                            .foregroundColor(.gray)
                        Text("\(viewModel.weeklySum(array: result, week: item).pause.toTimeString())")
                            .bold()
                    }
                    .foregroundColor(Color("Orange"))
                    
                }
                .roundedBackgroundWithBorder
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
