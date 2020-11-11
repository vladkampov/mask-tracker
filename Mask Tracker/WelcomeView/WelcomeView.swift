//
//  WelcomeView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 16.10.2020.
//

import SwiftUI

struct WelcomeView: View {
    var onContinue: (() -> Void) = {}

    func onContinueTap() {
        onContinue()
    }

    var body: some View {
            VStack(alignment: .center) {
                WelcomeTitleView()

                InformationContainerView()
                Spacer()
                Button(action: onContinueTap) {
                    Text("welcome.continue")
                        .customButton()
                }
                .padding(.all)
            }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView().environment(\.locale, .init(identifier: "uk"))
        }
    }
}
