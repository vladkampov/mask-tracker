//
//  WelcomeTitleView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 16.10.2020.
//

import SwiftUI

struct WelcomeTitleView: View {
    var body: some View {
        VStack {
            Image("Mask Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, alignment: .center)
                .accessibility(hidden: true)

            Text("welcome.welcome")
                .customTitleText()

            Text("welcome.mainTitle")
                .customTitleText()
                .foregroundColor(Color("Blue2"))
        }
    }
}

struct WelcomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTitleView()
    }
}
