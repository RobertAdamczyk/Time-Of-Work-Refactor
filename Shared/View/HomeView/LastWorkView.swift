//
//  LastWorkView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 19.03.21.
//

import SwiftUI

struct LastWorkView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @FetchRequest(entity: Dates.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)])
    var result: FetchedResults<Dates>

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if viewModel.lastRecord != nil {
                Text("LAST WORK")
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray.opacity(0.8))
                    .padding(.leading)
                HStack {
                    Spacer()
                    VStack(spacing: 5) {
                        HStack { // hstack for date
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                            if viewModel.lastRecord!.night {
                                Text("\(viewModel.lastRecord!.date, style: .date) - \(viewModel.lastRecord!.date.plusOneDay() ?? Date(), style: .date)")
                            } else {
                                Text("\(viewModel.lastRecord!.date, style: .date)")
                            }
                        }
                        HStack(spacing: 10) { // hstack for timeIn and timeOut
                            HStack(spacing: 2) {
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .foregroundColor(.green)
                                Text("\(viewModel.lastRecord!.timeIn, style: .time)")
                            }
                            HStack(spacing: 2) {
                                Image(systemName: "arrowshape.turn.up.left.fill")
                                    .foregroundColor(.red)
                                Text("\(viewModel.lastRecord!.timeOut, style: .time)")
                            }
                        }
                        HStack(spacing: 10) { // hstack for secwork and secpause
                            HStack(spacing: 2) {
                                Image(systemName: "hammer.fill")
                                    .foregroundColor(.gray)
                                Text("\(viewModel.lastRecord!.secWork!.toTimeString())")
                            }
                            HStack(spacing: 2) {
                                Image(systemName: "pause.circle")
                                    .foregroundColor(.gray)
                                Text("\(viewModel.lastRecord!.secPause.toTimeString())")
                            }
                        }
                    }// close VStack
                    Spacer()
                }
                .overlay(
                    HStack {
                        Rectangle()
                            .fill(Color("Orange"))
                            .frame(width: 2)
                        Spacer()
                    }
                )
                .padding()
                .roundedBackgroundWithBorder
            }
        }
        .padding(.horizontal)
        .padding(.vertical, viewModel.padding)
        .onAppear {
            viewModel.loadLast(result: result)
        }
        .onChange(of: viewModel.working) { _ in
            viewModel.loadLast(result: result)
        }
    }
}

struct LastWorkView_Previews: PreviewProvider {
    static var previews: some View {
        LastWorkView()
    }
}
