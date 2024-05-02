//
//  Persistence.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import CoreData
import SwiftUI
import WidgetKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "stinkless")
        
        // for widget
        let url = URL.storeURL(for: "group.stinkless", databaseName: "stinkless")
        let storeDescription = NSPersistentStoreDescription(url: url)
        container.persistentStoreDescriptions = [storeDescription]
        // ----------

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// for widget
public extension URL {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Unable to create URL for \(appGroup)")
        }
        
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
// ----------

// for views
//func addItemPersistence(viewContext: NSManagedObjectContext, items: FetchedResults<Item>, increment: Int, reset: Bool) {
//    let newItem = Item(context: viewContext)
//    newItem.timestamp = Date()
//    newItem.increment = Int64(increment)
//    newItem.reset = reset
//    if items.count == 0 {
//        newItem.valueBefore = 0
//    } else {
//        newItem.valueBefore = items[0].valueAfter
//    }
//    if reset == false {
//        newItem.valueAfter = newItem.valueBefore + newItem.increment
//    } else {
//        newItem.valueAfter = 0
//    }
//    newItem.maxGoal = Int64(getCurrentIntValue(key: maxGoalDefaultKey))
//        
//
//    do {
//        try viewContext.save()
//        WidgetCenter.shared.reloadAllTimelines()
//    } catch {
//        // Replace this implementation with code to handle the error appropriately.
//        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        let nsError = error as NSError
//        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//    }
//}

func addItemPersistence(viewContext: NSManagedObjectContext, count: Int, latestValue: Int, increment: Int, reset: Bool) {
    let newItem = Item(context: viewContext)
    newItem.timestamp = Date()
    newItem.increment = Int64(increment)
    newItem.reset = reset
    if count == 0 {
        newItem.valueBefore = 0
    } else {
        newItem.valueBefore = Int64(latestValue)
    }
    if reset == false {
        newItem.valueAfter = newItem.valueBefore + newItem.increment
    } else {
        newItem.valueAfter = 0
    }
    newItem.maxGoal = Int64(getCurrentIntValue(key: maxGoalDefaultKey))
        

    do {
        try viewContext.save()
        WidgetCenter.shared.reloadAllTimelines()
    } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}
