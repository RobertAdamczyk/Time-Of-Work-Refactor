//
//  AboutView.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 27.03.21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                SettingHeaderView(name: "About")
                VStack {
                    HStack {
                        Spacer()
                        Image("Icon")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(15)
                            .roundedBackgroundWithBorder
                        Spacer()
                    }
                    VStack {
                        Text("Created by Robert Adamczyk")
                        Text("Version 1.1.0")
                    }
                    .font(.subheadline)
                    VStack {
                        Text("The app was made to keep track of your working hours as simple as possible." +
                             " If you like it, leave a review on the AppStore. Thanks for using my application. ❤️❤️❤️ ")
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .roundedBackgroundWithBorder
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
