//
//  helpers.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import Foundation
import SwiftUI

func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
  return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

func usedPercentage(current: Int32, max: Int32) -> Double {
    return ((Double(current) / Double(max)) * 100)
}

func getTimeColor(percent: Double, defaultColor: Color?) -> Color? {
    if percent >= 80 && percent < 95 {
        return Color("Yellow")
    }

    if percent >= 95 {
        return Color("Red")
    }

    return defaultColor ?? nil
}
