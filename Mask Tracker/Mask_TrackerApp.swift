//
//  Mask_TrackerApp.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI
import UserNotifications

@main
struct MaskTrackerApp: App {
    let persistenceController = PersistenceController.shared

    func onLoad() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications are enabled!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    var body: some Scene {
        return WindowGroup {
            MaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).onAppear(perform: onLoad)
        }
    }
}
