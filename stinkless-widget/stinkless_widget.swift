//
//  stinkless_widget.swift
//  stinkless-widget
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @Environment(\.managedObjectContext) private var viewContext
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    
//    func getItems() throws -> [Item] {
//        
//        let context = PersistenceController.shared.container.viewContext
//        
//        let request = Item.fetchRequest()
//        let result = try context.fetch(request)
//        
//        return result
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct stinkless_widgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.colorScheme) var cs

    var body: some View {
        WidgetEntryView(entry: entry)
            .containerBackground(getBackGroundStyle(), for: .widget)
    }
    
    func getBackGroundStyle() -> Color {
        switch cs {
        case .light:
            return Color.white
        case .dark:
            return Color.black
        default:
            return Color(UIColor.systemBackground)
        }
    }
}

// TODO: env fore and background colors

struct stinkless_widget: Widget {
    let persistenceController = PersistenceController.shared
    
    let kind: String = "stinkless_widget"

    @Environment(\.colorScheme) var cs

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            stinkless_widgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .defaultAppStorage(UserDefaults(suiteName: "group.stinkless")!)
                .applyColorScheme(getColorScheme())

//                .containerBackground(for: .widget) {
//                    getBackGroundStyle()
//                }
            
//            if #available(iOS 17.0, *) {
//                stinkless_widgetEntryView(entry: entry)
//                    .containerBackground(.fill.tertiary, for: .widget)
//            } else {
//                stinkless_widgetEntryView(entry: entry)
//                    .padding()
//                    .background()
//            }
        }
        .configurationDisplayName("stinkless widget")
        .description("")

    }
    
//    func getBackGroundStyle() -> Color {
//        switch cs {
//        case .light:
//            return Color.white
//        case .dark:
//            return Color.black
//        default:
//            return Color(UIColor.systemBackground)
//        }
//    }
}

//#Preview(as: .systemSmall) {
//    stinkless_widget()
//} timeline: {
//    SimpleEntry(date: .now, currValue: 4)
//}
