//
//  App.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 11.11.2020.
//

import SwiftUI
import CoreData

struct Main: View {
    @ObservedObject var settings = UserSettings()
    
    private func onContinue() {
        settings.isWelcomeAccepted = true
    }

    var body: some View {
        return ZStack {
            if !settings.isWelcomeAccepted {
                WelcomeView(onContinue: onContinue)
            } else {
                MaskListView()
            }
        }
    }
}

#if DEBUG
struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
