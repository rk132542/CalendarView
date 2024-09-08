//
//  CalendarLiveLiveActivity.swift
//  CalendarLive
//
//  Created by Riku on 2024/09/02.
//

import ActivityKit
import WidgetKit
import SwiftUI
import SwiftData


struct CalendarLiveAttributes: ActivityAttributes {
    public typealias CalendarStatus = ContentState
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
        var classIndex: Int
    }

    // Fixed non-changing properties about your activity go here!
    
}


struct CalendarLiveLiveActivity: Widget {
    @Environment(\.modelContext) private var modelContext
    @Query var dataEvents: [Event]

    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CalendarLiveAttributes.self) { context in
            
            let displayEvents: [Event] = Event.getEventToDisplay(dataEvents: dataEvents, dateTime: Date.init(timeIntervalSinceNow: 78600))
        
            
            HStack {
                // Left Side
                VStack(alignment: .leading) {
                    
                    
                    
                    // Current Event
                    
                    HStack {
                        Rectangle()
                            .cornerRadius(3.0)
                            .frame(width: 4)
                        VStack {
                            
                            HStack {
                                Text("\(displayEvents[0].stringStartTime())~\(displayEvents[0].stringEndTime())")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                HStack(alignment:.lastTextBaseline, spacing: 0) {
                                    Image(systemName: "mappin")
                                    Text("309")
                                }
                            }
                            .font(.footnote)
                            
                            HStack {
                                Text("IB Visual Arts HL")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            
                        }
                    }
                    
                    
                    
                    
                    // Upcoming Event
                    VStack {
                        HStack {
                            Text("IB Program Design Technology bla bla bla bla")
                                .multilineTextAlignment(.leading)
                            Spacer()
                            HStack(alignment:.lastTextBaseline) {
                                Image(systemName: "mappin")
                                Text("309")
                            }
                        }
                        HStack {
                            Text("IB English A Language/Literature")
                                .multilineTextAlignment(.leading)
                            Spacer()
                            HStack(alignment:.lastTextBaseline) {
                                Image(systemName: "mappin")
                                Text("309")
                            }
                        }
                        HStack {
                            Text("IB Math")
                                .multilineTextAlignment(.leading)
                            Spacer()
                            HStack(alignment:.lastTextBaseline) {
                                Image(systemName: "mappin")
                                Text("309")
                            }
                        }
                    }
                    .font(.callout)
                    .fontWeight(.light)
                }
                .frame(alignment: .leading)
                .padding(.trailing, 5)
                // Left Side end
                
                // Right Side
                Divider()
                    
                VStack(alignment:.leading) {
                    ZStack {
                        Text(" IB Biology SL")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.gray)
                            .background(Rectangle()
                                .fill(.black.opacity(0.2)).cornerRadius(5.0))
                    }
                    ZStack {
                        Text(" IB Biology SL")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.gray)
                            .background(Rectangle()
                                .fill(.black.opacity(0.2)).cornerRadius(5.0))
                    }
                    ZStack {
                        Text(" ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.white)
                            .background(Rectangle()
                                .fill(
                                                       LinearGradient(
                                                        gradient: Gradient(colors: [.black.opacity(0.2), .black.opacity(0.2), .black]),
                                                           startPoint: .top,
                                                           endPoint: .bottom
                                                       )
                                                   )
                            )
                            .cornerRadius(5.0)
                        Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 3, dash: [6]))
                                    .frame(height: 1)
                                    
                                    .foregroundColor(.black)
                                    .offset(y: 0)
                    }
                    
                    ZStack {
                        Text(" IB Biology SL")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.white)
                            .background(Rectangle()
                                .fill(.black).cornerRadius(5.0))
                    }
                    ZStack {
                        Text(" IB Biology SL")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.white)
                            .background(Rectangle()
                                .fill(.black).cornerRadius(5.0))
                    }
                    ZStack {
                        Text(" IB Biology SL")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.white)
                            .background(Rectangle()
                                .fill(.black).cornerRadius(5.0))
                    }
                }
                .fontWeight(.light)
                .padding(.leading, 5)
                .font(.footnote)
                // Right Side end
            }
            //            VStack {
            //                Text("Hello \(context.state.emoji)")
            //            }
            .padding()
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
        CalendarLiveAttributes()
    }
}

extension CalendarLiveAttributes.ContentState {
    fileprivate static var dayDone: CalendarLiveAttributes.ContentState {
        CalendarLiveAttributes.ContentState(emoji: "😀", classIndex: 3)
     }
     
     fileprivate static var starEyes: CalendarLiveAttributes.ContentState {
         CalendarLiveAttributes.ContentState(emoji: "🤩", classIndex: 4)
     }
}

#Preview("Notification", as: .content, using: CalendarLiveAttributes.preview) {
    CalendarLiveLiveActivity()

}
contentStates: {
    CalendarLiveAttributes.ContentState.dayDone
    CalendarLiveAttributes.ContentState.starEyes
}

