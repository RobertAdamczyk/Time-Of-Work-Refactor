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
            VStack(spacing: 4) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(context.state.context == .work ? localized(string: "generic_your_work") : localized(string: "generic_your_pause"))
                            .font(.caption2)
                        Spacer(minLength: 0)
                        Text("\(context.state.dateForTimer, style: .timer)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(context.attributes.isDarkMode ? Color.theme.accent : Color.theme.black)
                        Spacer(minLength: 0)
                    }
                    .frame(width: 165)
                    Spacer()
                    if let url = URL(string: LiveActivitiesService.DeepLink.pauseButton.rawValue),
                        context.attributes.liveActivitiesPauseButton {
                        Link(destination: url) {
                            VStack(spacing: 2) {
                                ImageStore.pauseCircle.image
                                    .font(.largeTitle)
                                    .frame(height: 35)
                                Spacer(minLength: 0)
                                Text(context.state.context == .work ? localized(string: "generic_start_pause") : localized(string: "generic_end_pause"))
                                    .font(.caption2)
                                    .multilineTextAlignment(.center)
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    if let url2 = URL(string: LiveActivitiesService.DeepLink.endWorkButton.rawValue),
                        context.attributes.liveActivitiesEndWorkButton {
                        Spacer()
                        Link(destination: url2) {
                            VStack(spacing: 2) {
                                ImageStore.arrowUpLeft.image
                                    .font(.largeTitle)
                                    .foregroundColor(Color.theme.red)
                                    .frame(height: 35)
                                Spacer(minLength: 0)
                                Text(localized(string: "generic_end_work"))
                                    .font(.caption2)
                                    .multilineTextAlignment(.center)
                                Spacer(minLength: 0)
                            }
                        }
                    }
                }
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Text("\(localized(string: "live_activities_start_at")):")
                        Text("\(context.state.startWorkDate, style: .time)")
                            .fontWeight(.medium)
                            .foregroundColor(context.attributes.isDarkMode ? Color.theme.accent : Color.theme.black)
                    }
                    HStack(spacing: 4) {
                        switch context.state.context {
                        case .pause:
                            Text("\(localized(string: "generic_work")):")
                            Text("\(context.state.workInSec.toTimeStringTimerFormat())")
                                .fontWeight(.medium)
                                .foregroundColor(context.attributes.isDarkMode ? Color.theme.accent : Color.theme.black)
                        case .work:
                            Text("\(localized(string: "generic_pause")):")
                            Text("\(context.state.pauseInSec.toTimeStringTimerFormat())")
                                .fontWeight(.medium)
                                .foregroundColor(context.attributes.isDarkMode ? Color.theme.accent : Color.theme.black)
                        }
                    }
                    Spacer()
                }
                .font(.caption2)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .customBackground(colorScheme: context.attributes.isDarkMode ? .dark : .light)
        } dynamicIsland: { _ in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text(" ")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(" ")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(" ")
                    // more content
                }
            } compactLeading: {
                Text(" ")
            } compactTrailing: {
                Text(" ")
            } minimal: {
                Text(" ")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension View {

    func customBackground(colorScheme: ColorScheme) -> some View {
        switch colorScheme {
        case .light:
            self
                .activityBackgroundTint(Color.theme.widgetBackgroundLight)
        case .dark:
            self
                .activityBackgroundTint(Color.theme.widgetBackgroundDark)
        @unknown default:
            self
                .activityBackgroundTint(Color.theme.widgetBackgroundLight)
        }
    }
}
