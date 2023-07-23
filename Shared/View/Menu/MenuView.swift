//
//  MenuView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 06.12.22.
//

import SwiftUI

final class MenuViewModel: ObservableObject {

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func onBackgroundTapped() {
        coordinator.hideMenu()
    }

    func onSettingsTapped() {
        coordinator.push(.settings(.main))
        coordinator.hideMenu()
    }
}

struct MenuView: View {
    @StateObject var viewModel: MenuViewModel

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Color.theme.background.opacity(0.01)
                .onTapGesture(perform: viewModel.onBackgroundTapped)
            ZStack {
                Color.theme.background
                VStack(alignment: .leading, spacing: 20) {
                    NavigationItem(imageStore: .gearshape,
                                   title: localized(string: "generic_settings"))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.onSettingsTapped()
                    }
                    Divider()
                    Spacer()
                }
                .padding(.vertical, 150)
                .padding(.horizontal, 16)
            }
            .frame(width: Config.menuWidth)
        }
        .ignoresSafeArea()
    }
}

// MARK: Cell views
extension MenuView {
    private struct NavigationItem: View {
        var imageStore: ImageStore
        var title: String
        var body: some View {
            VStack {
                HStack {
                    imageStore.image
                        .foregroundColor(Color.theme.accent)
                    Text(title)
                        .foregroundColor(Color.theme.text)
                    Spacer()
                    ImageStore.chevronRight.image
                        .foregroundColor(Color.theme.accent)
                        .font(.system(size: 16, weight: .black))
                }
            }
        }
    }

    private struct ButtonItem: View {
        var imageStore: ImageStore
        var title: String
        var action: () -> Void
        var body: some View {
            Button {
                action()
            } label: {
                VStack {
                    HStack {
                        imageStore.image
                            .foregroundColor(Color.theme.accent)
                        Text(title)
                            .foregroundColor(Color.theme.text)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(coordinator: .init())
    }
}
