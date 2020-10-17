//
//  Mask_TrackerApp.swift
//  Mask Tracker Watch App Extension
//
//  Created by Vladyslav Kampov on 17.10.2020.
//

import SwiftUI

@main
struct Mask_TrackerApp: App {
    let persistenceController = PersistenceControllerWatch.shared

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "maskTracker")
    }
}
