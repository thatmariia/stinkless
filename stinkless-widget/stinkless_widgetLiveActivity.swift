//
//  stinkless_widgetLiveActivity.swift
//  stinkless-widget
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct stinkless_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct stinkless_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: stinkless_widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension stinkless_widgetAttributes {
    fileprivate static var preview: stinkless_widgetAttributes {
        stinkless_widgetAttributes(name: "World")
    }
}

extension stinkless_widgetAttributes.ContentState {
    fileprivate static var smiley: stinkless_widgetAttributes.ContentState {
        stinkless_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: stinkless_widgetAttributes.ContentState {
         stinkless_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: stinkless_widgetAttributes.preview) {
   stinkless_widgetLiveActivity()
} contentStates: {
    stinkless_widgetAttributes.ContentState.smiley
    stinkless_widgetAttributes.ContentState.starEyes
}
