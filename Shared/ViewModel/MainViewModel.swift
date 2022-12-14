//
//  MainViewModel.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 21.03.21.
//
import Foundation

class MainViewModel: ObservableObject {
    @Published var view = Views.home
    @Published var activeSheet: SheetView?
}
