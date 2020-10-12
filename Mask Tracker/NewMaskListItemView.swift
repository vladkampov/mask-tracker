//
//  NewMaskListItemView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI
import CoreData

struct NewMaskListItemView: View {

    var body: some View {
        return NavigationLink(
            destination: NewMaskView()) {
            GeometryReader { geometry in
                CardView(title: "newMaskCard.title", description: "newMaskCard.description", image: "Mask Placeholder", isRunning: false)
                    .rotation3DEffect(
                        Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / 20 ),
                        axis: (x: 0.0, y: 10.0, z: 0.0))
            }.frame(width: 246)
        }
    }
}

struct NewMaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewMaskListItemView()
    }
}
