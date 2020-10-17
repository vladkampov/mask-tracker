//
//  MaskDataWatch+CoreDataProperties.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 17.10.2020.
//
//

import Foundation
import CoreData

extension MaskDataWatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaskDataWatch> {
        return NSFetchRequest<MaskDataWatch>(entityName: "MaskDataWatch")
    }

    @NSManaged public var changedAt: Date?
    @NSManaged public var createdAt: Date
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var isCounterActive: Bool
    @NSManaged public var secondsInUse: Int32
    @NSManaged public var secondsToBeUsed: Int32
    @NSManaged public var usedTimes: Int32
}

extension MaskDataWatch: Identifiable {

}
