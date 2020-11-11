//
//  MaskData+CoreDataProperties.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 17.10.2020.
//
//

import Foundation
import CoreData

extension MaskData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaskData> {
        return NSFetchRequest<MaskData>(entityName: "MaskData")
    }

    @NSManaged public var changedAt: Date?
    @NSManaged public var createdAt: Date
    @NSManaged public var id: UUID
    @NSManaged public var isCounterActive: Bool
    @NSManaged public var name: String
    @NSManaged public var secondsInUse: Int32
    @NSManaged public var secondsToBeUsed: Int32
    @NSManaged public var usedTimes: Int32
    @NSManaged public var staticSecondsInUse: Int32
}

extension MaskData: Identifiable {

}
