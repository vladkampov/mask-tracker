//
//  WelcomeView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 16.10.2020.
//

import SwiftUI

struct WelcomeView: View {
    private let userDefaults = UserDefaults.standard

    private func onContinue() {
        userDefaults.setValue(true, forKey: "isWelcomeAccepted")
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {

                Spacer()

                WelcomeTitleView()

                InformationContainerView()

                Spacer(minLength: 30)

                Button(action: onContinue) {
                    Text("welcome.continue")
                        .customButton()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
