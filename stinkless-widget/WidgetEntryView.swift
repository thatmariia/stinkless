//
//  WidgetEntryView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

struct WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var maxGoal = getCurrentIntValue(key: maxGoalDefaultKey)
    
    var entry: Provider.Entry


    var body: some View {
        ZStack {
            switch widgetFamily {
            case .systemMedium:
                HStack {
                    VStack {
                        
                        // reset button
                        ResetButtonView(itemSize: 16)
                            .environment(\.managedObjectContext, viewContext)
                            .padding(1)
                        
                        // curr progress
                        CurrValueAndGoalView(maxGoal: $maxGoal, itemSize: 35)
                            .environment(\.managedObjectContext, viewContext)
                            .padding(1)
                    }
                    
                    Spacer().frame(width: 20)
                    
                    
                    // buttons to add / remove
                    AddRemoveItemsView(itemSize: 60)
                        .environment(\.managedObjectContext, viewContext)
                        .padding(1)
                }
            case .systemLarge:
                VStack {
                    
                    // reset button
                    ResetButtonView(itemSize: 16)
                        .environment(\.managedObjectContext, viewContext)
                        .padding(1)
                    
                    // curr progress
                    CurrValueAndGoalView(maxGoal: $maxGoal, itemSize: 50)
                        .environment(\.managedObjectContext, viewContext)
                        .padding(1)
                    
                    // buttons to add / remove
                    AddRemoveItemsView(itemSize: 100)
                        .environment(\.managedObjectContext, viewContext)
                        .padding(1)
                }
            default:
                VStack {
                    
                    // reset button
                    ResetButtonView(itemSize: 16)
                        .environment(\.managedObjectContext, viewContext)
                        .padding(1)
                    
                    // curr progress
                    CurrValueAndGoalView(maxGoal: $maxGoal, itemSize: 20)
                        .environment(\.managedObjectContext, viewContext)
                        .padding(1)
                    
                    // buttons to add / remove
                    AddRemoveItemsView(itemSize: 40)
                        .environment(\.managedObjectContext, viewContext)
                        .padding(1)
                }
            }
            
        }
        .onAppear {
            maxGoal = getCurrentIntValue(key: maxGoalDefaultKey)
        }
        .buttonStyle(PlainButtonStyle())
    }

}
