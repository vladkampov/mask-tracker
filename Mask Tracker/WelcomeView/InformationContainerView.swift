//
//  InformationContainerView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 16.10.2020.
//

import SwiftUI

struct InformationContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InformationView(title: "welcome.title1", subTitle: "welcome.description1", imageName: "slider.horizontal.below.rectangle")

            InformationView(title: "welcome.title2", subTitle: "welcome.description2", imageName: "minus.slash.plus")

            InformationView(title: "welcome.title3", subTitle: "welcome.description3", imageName: "checkmark.square")
        }
        .padding(.horizontal)
    }
}

struct InformationContainerView_Previews: PreviewProvider {
    static var previews: some View {
        InformationContainerView()
    }
}
