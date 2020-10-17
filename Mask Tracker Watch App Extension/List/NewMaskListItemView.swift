//
//  NewMaskListItem.swift
//  Mask Tracker Watch App Extension
//
//  Created by Vladyslav Kampov on 17.10.2020.
//

import SwiftUI

struct NewMaskListItemView: View {
    var listLength: Int

    var body: some View {
        NavigationLink(
            destination: NewMaskView()) {
            WatchCardView(title: "newMaskCard.title", description: listLength == 0 ? "newMaskCard.descriptionZero" : "newMaskCard.description", image: "Mask Placeholder", isRunning: false)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct NewMaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            NewMaskListItemView(listLength: 0)
            NewMaskListItemView(listLength: 2)
        }
    }
}
