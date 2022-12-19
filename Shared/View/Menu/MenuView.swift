//
//  MenuView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 06.12.22.
//

import SwiftUI

class MenuViewModel: ObservableObject {

}

struct MenuView: View {
    @StateObject var viewModel: MenuViewModel = MenuViewModel()
    @EnvironmentObject var mainViewModel: MainViewModel
    var body: some View {
        ZStack(alignment: .leading) {
            Color.theme.background.opacity(0.01)
                .onTapGesture {
                    mainViewModel.showMenuAction()
                }
            ZStack {
                Color.theme.background
                VStack(alignment: .leading, spacing: 30) {
                    NavigationLink(destination: MainSettingView()) {
                        HStack {
                            Image.store.gearshape
                            Text("Settings")
                                .foregroundColor(Color.theme.text)
                        }
                    }
//                    Button {
//
//                    } label: {
//                        HStack {
//                            Image.store.envelope
//                            Text("Feedback")
//                                .foregroundColor(Color.theme.buttonText)
//                        }
//                    }

                    Spacer()
                }
                .padding(.vertical, 150)
            }
            .frame(width: Config.menuWidth)
        }
        .ignoresSafeArea()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
