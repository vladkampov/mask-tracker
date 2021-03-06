//
//  MaskListItemView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI
import CoreData

struct MaskListItemView: View {
    @ObservedObject var mask: MaskData

    var body: some View {
        let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: Int(mask.secondsInUse))
        let percent = usedPercentage(current: mask.secondsInUse, max: mask.secondsToBeUsed)

        return NavigationLink(
            destination: MaskDetailView(mask: mask)) {
            CardView(title: mask.name, description: String(format: "%02i:%02i:%02i", hours, minutes, seconds), image: "", percent: percent == 0 ? 0.1 : percent, isRunning: mask.isCounterActive)
        }.buttonStyle(PlainButtonStyle())
    }
}

#if DEBUG
struct MaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let m = MaskData(context: PersistenceController.preview.container.viewContext)
        m.id = UUID()
        m.name = "Lalka"
        m.changedAt = Date()
        m.createdAt = Date()
        m.isCounterActive = false
        m.secondsInUse = 123
        m.secondsToBeUsed = 7300
        return MaskListItemView(mask: m).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
