//
//  UserSettings.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 18.10.2020.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

final class UserSettings: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()

    @UserDefault("isWelcomeAccepted", defaultValue: false)
    var isWelcomeAccepted: Bool {
        willSet {
            objectWillChange.send()
        }
    }
}
