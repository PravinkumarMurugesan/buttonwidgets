//
//  IncreaseIntentLiveActivity.swift
//  IncreaseIntent
//
//  Created by Pravinkumar on 21/01/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct IncreaseIntentAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct IncreaseIntentLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: IncreaseIntentAttributes.self) { context in
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

extension IncreaseIntentAttributes {
    fileprivate static var preview: IncreaseIntentAttributes {
        IncreaseIntentAttributes(name: "World")
    }
}

extension IncreaseIntentAttributes.ContentState {
    fileprivate static var smiley: IncreaseIntentAttributes.ContentState {
        IncreaseIntentAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: IncreaseIntentAttributes.ContentState {
         IncreaseIntentAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: IncreaseIntentAttributes.preview) {
   IncreaseIntentLiveActivity()
} contentStates: {
    IncreaseIntentAttributes.ContentState.smiley
    IncreaseIntentAttributes.ContentState.starEyes
}
