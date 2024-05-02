//
//  widgetIntents.swift
//  stinkless-widgetExtension
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI
import AppIntents
import CoreData
import WidgetKit

struct AddItemIntent: AppIntent {
    
    static var title: LocalizedStringResource = "add item intent"
    
    @Parameter(title: "increment")
    var increment: Int
    
    @Parameter(title: "reset")
    var reset: Bool
    
    @Parameter(title: "count")
    var count: Int
    
    @Parameter(title: "latestValue")
    var latestValue: Int
    
    init(count: Int, latestValue: Int, increment: Int, reset: Bool) {
        self.count = count
        self.latestValue = latestValue
        self.increment = increment
        self.reset = reset
    }
    
    init() {
        self.count = 0
        self.latestValue = 0
        self.increment = 0
        self.reset = false
    }
    
    
    func perform() async throws -> some IntentResult {
        let viewContext = PersistenceController.shared.container.viewContext
        
        addItemPersistence(viewContext: viewContext, count: count, latestValue: latestValue, increment: increment, reset: reset)
        
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
        
    }
} 

//struct ChangeGoalIntent: AppIntent {
//    static var title: LocalizedStringResource = "Change goal"
//    
//    @Parameter(title: "increment")
//    var increment: Int
//    
//    init(increment: Int) {
//        self.increment = increment
//    }
//    
//    init() {
//        self.increment = 0
//    }
//    
//    func perform() async throws -> some IntentResult {
////        if let store = defaults {
////            // get curr value from the store: store.integer(forKey: "blah")
////            // increase and add back to the store
////            return .result()
////        }
//        
//        let maxGoal = defaults.integer(forKey: maxGoalDefaultKey)
//        defaults.set(maxGoal + increment, forKey: maxGoalDefaultKey)
//        
//        return .result()
//    }
//}
