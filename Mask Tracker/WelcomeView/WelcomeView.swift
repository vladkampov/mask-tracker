//
//  WelcomeView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 16.10.2020.
//

import SwiftUI

struct WelcomeView: View {
    var onContinue: (() -> ()) = {}
    
    func onContinueTap() {
        onContinue()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {

                Spacer()

                WelcomeTitleView()

                InformationContainerView()

                Spacer(minLength: 30)

                Button(action: onContinueTap) {
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
