//
//  Persistence.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import CoreData

public extension URL {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}

struct PersistenceControllerWatch {
    static let shared = PersistenceControllerWatch()

    static var preview: PersistenceControllerWatch = {
        let result = PersistenceControllerWatch(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<5 {
            let newItem = MaskDataWatch(context: viewContext)
            newItem.id = UUID()
            newItem.name = "New mask"
            newItem.secondsInUse = 0
            newItem.secondsToBeUsed = 0
            newItem.usedTimes = 0
            newItem.createdAt = Date()
            newItem.changedAt = Date()
            newItem.isCounterActive = false
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "MaskDataWatch")

        let storeURL = URL.storeURL(for: "group.MaskTracker", databaseName: "group.MaskTracker")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [storeDescription]
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {

        }

        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
