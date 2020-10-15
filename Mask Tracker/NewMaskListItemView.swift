//
//  NewMaskListItemView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI
import CoreData

struct NewMaskListItemView: View {
    var listLength: Int

    var body: some View {
        return NavigationLink(
            destination: NewMaskView()) {
            CardView(title: "newMaskCard.title", description: listLength == 0 ? "newMaskCard.descriptionZero" : "newMaskCard.description", image: "Mask Placeholder", isRunning: false)
        }
    }
}

struct NewMaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            NewMaskListItemView(listLength: 0)
            NewMaskListItemView(listLength: 2)
        }
    }
}
