//
//  MaskData+CoreDataProperties.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//
//

import Foundation
import CoreData

extension MaskData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaskData> {
        return NSFetchRequest<MaskData>(entityName: "MaskData")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var secondsInUse: Int32
    @NSManaged public var secondsToBeUsed: Int32
    @NSManaged public var usedTimes: Int32
    @NSManaged public var createdAt: Date
    @NSManaged public var changedAt: Date?
    @NSManaged public var isCounterActive: Bool
    @NSManaged public var image: String

}

extension MaskData: Identifiable {

}
