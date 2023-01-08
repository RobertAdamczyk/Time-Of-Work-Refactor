//
//  LiveWorkLiveActivity.swift
//  LiveWork
//
//  Created by Robert Adamczyk on 26.12.22.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveWorkLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveWorkAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(context.state.context == .work ? "Your work" : "Your pause")
                            .font(.caption2)
                        Text("\(context.state.dateForTimer, style: .timer)")
                            .font(.title)
                            .foregroundColor(Color.theme.accent)
                    }
                    .frame(width: 165)
                    Spacer()
                    if let url = URL(string: LiveWorkViewModel.DeepLink.pauseButton.rawValue),
                        context.attributes.liveActivitiesPauseButton {
                        Link(destination: url) {
                            VStack {
                                Image.store.pauseCircle
                                    .font(.largeTitle)
                                Text(context.state.context == .work ? "Start pause" : "End pause")
                                    .font(.caption2)
                            }
                        }
                    }
                    if let url2 = URL(string: LiveWorkViewModel.DeepLink.endWorkButton.rawValue),
                        context.attributes.liveActivitiesEndWorkButton {
                        Spacer()
                        Link(destination: url2) {
                            VStack {
                                Image.store.arrowUpLeft
                                    .font(.largeTitle)
                                    .foregroundColor(Color.theme.red)
                                Text("End work")
                                    .font(.caption2)
                            }
                        }
                    }
                }
                HStack(spacing: 5) {
                    Text("Start at:")
                    Text("\(context.state.startWorkDate, style: .time)").foregroundColor(Color.theme.accent)
                    switch context.state.context {
                    case .pause:
                        Text("Work:")
                        Text("\(context.state.workInSec.toTimeStringTimerFormat())")
                            .foregroundColor(Color.theme.accent)
                    case .work:
                        Text("Pause:")
                        Text("\(context.state.pauseInSec.toTimeStringTimerFormat())")
                            .foregroundColor(Color.theme.accent)
                    }
                    Spacer()
                }
                .font(.caption2)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
        } dynamicIsland: { _ in
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
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
