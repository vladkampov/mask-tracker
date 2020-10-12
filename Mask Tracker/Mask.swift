//
//  Mask.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI

class Mask: Identifiable, ObservableObject {
    var id = UUID()
    var name: String = "New Mask"
    var image = "Mask Placeholder"
    var seondsMaxInUse = 7200

    @Published var secondsInUse = 0
    @Published var isCounterActive = false

    var timer: Timer?

    init(name: String?) {
        if name != nil {
            self.name = name!
        }
    }

    func startCounter() {
        isCounterActive = true

        timer = Timer.scheduledTimer(
            withTimeInterval: 0.1,
            repeats: true
        ) {_ in
            self.secondsInUse += 1
        }
    }

    func stopCounter() {
        isCounterActive = false
        timer?.invalidate()
    }
}

#if DEBUG
var testMasks = [
    MaskData(),
    MaskData(),
    MaskData()
]
#endif
