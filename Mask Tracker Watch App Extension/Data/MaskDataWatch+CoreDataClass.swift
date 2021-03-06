//
//  MaskDataWatch+CoreDataClass.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 17.10.2020.
//
//

import Foundation
import CoreData
import UserNotifications

@objc(MaskDataWatch)
public class MaskDataWatch: NSManagedObject {
    var timer: Timer?

    public override func awakeFromFetch() {
        if self.isCounterActive && self.changedAt != nil {
            self.secondsInUse = Int32(Date().timeIntervalSince(self.changedAt!))
            timer = Timer.scheduledTimer(
                withTimeInterval: 1,
                repeats: true
            ) {_ in
                self.secondsInUse += 1
            }
        }

//        NotificationCenter.default.addObserver(self, selector: #selector(onBackFromBG), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

//    @objc func onBackFromBG() {
//        if self.isCounterActive {
//            self.secondsInUse += Int32(Date().timeIntervalSince(self.changedAt!))
//        }
//    }

    private func notifyAboutMaskEnd() {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("notification.title", comment: "notification title")
        content.sound = UNNotificationSound.default
        content.body = NSLocalizedString("notification.body", comment: "notification body")

        // show this notification five seconds from now
        print(self.secondsInUse, self.secondsToBeUsed)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.secondsToBeUsed - self.secondsInUse), repeats: false)

        // mask name can be notification identifier
        // that's how we'll guarantee only one scheduled notification per mask
        let request = UNNotificationRequest(identifier: self.name, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }

    private func resetNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.name])
    }

    public func startCounter() {
        self.isCounterActive = true
        self.changedAt = Date()
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) {_ in
            self.secondsInUse += 1
        }

        notifyAboutMaskEnd()
    }

    public func stopCounter() {
        timer?.invalidate()
        self.isCounterActive = false
        self.changedAt = Date()

        if self.secondsInUse >= self.secondsToBeUsed {
            self.usedTimes += self.usedTimes
        }

        resetNotification()
    }

    public func resetCounter() {
        timer?.invalidate()
        self.isCounterActive = false
        self.changedAt = Date()
        self.secondsInUse = 0
        self.usedTimes += self.usedTimes

        resetNotification()
    }

    public override func prepareForDeletion() {
        timer?.invalidate()
        timer = nil

        resetNotification()
    }
}
