//
//  CalendarLiveLiveActivity.swift
//  CalendarLive
//
//  Created by Riku on 2024/09/02.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CalendarLiveAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CalendarLiveLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CalendarLiveAttributes.self) { context in
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

extension CalendarLiveAttributes {
    fileprivate static var preview: CalendarLiveAttributes {
        CalendarLiveAttributes(name: "World")
    }
}

extension CalendarLiveAttributes.ContentState {
    fileprivate static var smiley: CalendarLiveAttributes.ContentState {
        CalendarLiveAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: CalendarLiveAttributes.ContentState {
         CalendarLiveAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: CalendarLiveAttributes.preview) {
   CalendarLiveLiveActivity()
} contentStates: {
    CalendarLiveAttributes.ContentState.smiley
    CalendarLiveAttributes.ContentState.starEyes
}
