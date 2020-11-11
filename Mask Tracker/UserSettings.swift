//
//  UserSettings.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 18.10.2020.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var isWelcomeAccepted: Bool {
        didSet {
            UserDefaults.standard.set(isWelcomeAccepted, forKey: "isWelcomeAccepted")
        }
    }

    init() {
        self.isWelcomeAccepted = UserDefaults.standard.object(forKey: "isWelcomeAccepted") as? Bool ?? false
    }
}
