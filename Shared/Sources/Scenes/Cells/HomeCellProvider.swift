//
//  HomeCellProvider.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 29.11.22.
//

import SwiftUI

protocol HomeCellProvider {
    func makeCellShape(colorScheme: ColorScheme) -> AnyView
}

extension HomeCellProvider where Self: View {

    func makeCellShape(colorScheme: ColorScheme) -> AnyView {
        if colorScheme == .dark {
            return AnyView(RoundedRectangle(cornerSize: CellConfig.cornerSize)
                .foregroundStyle(Color.clear)
                .applyCellBackground()
            )
        } else {
            return AnyView(RoundedRectangle(cornerSize: CellConfig.cornerSize)
                .foregroundColor(Color.theme.cell)
                .shadow(color: Color.theme.shadow, radius: 5, x: 0, y: 4)
            )
        }
    }
}

enum HomeCell: View, CaseIterable {
    case idle
    case working

    var body: some View {
        switch self {
        case .idle:
            IdleCell()
        case .working:
            WorkingCell()
        }
    }
}
