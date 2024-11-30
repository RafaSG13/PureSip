//
//  PureSipWidgetLiveActivity.swift
//  PureSipWidget
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PureSipWidgetLiveActivity: Widget {

    private enum IconOption: String {
        case waterDropCircle = "drop.circle"
        case waterBottle = "waterbottle.fill"
    }

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PSLiveActivityAttributes.self) { context in
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
                    liveActivityIcon(icon: .waterDropCircle, size: CGSize(width: 40, height: 40))
                }
                DynamicIslandExpandedRegion(.trailing) {
                    liveActivityIcon(icon: .waterBottle, size: CGSize(width: 25, height: 40))
                        .padding(.horizontal)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack(spacing: 5) {
                        Text("Current Water Intake")
                            .font(.headline)
                            .fontDesign(.rounded)
                            .foregroundStyle(.cyan)
                        Text("50 %")
                            .font(.title3)
                            .bold()
                            .italic()
                            .foregroundStyle(.cyan)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 10)
                            .padding(.horizontal)
                        HorizontalWaveShape(progress: 0.5,
                                            waveHeight: 0.02,
                                            offset: 0)
                        .fill(.blue)
                        .mask {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 10)
                                .padding(.horizontal)
                        }
                    }
                }
            } compactLeading: {
                liveActivityIcon(icon: .waterDropCircle)
            } compactTrailing: {
                liveActivityIcon(icon: .waterBottle,
                                 size: CGSize(width: 12, height: 20))
            } minimal: {
                liveActivityIcon(icon: .waterDropCircle)
            }
            .keylineTint(.blue)
        }
    }

    @ViewBuilder
    private func liveActivityIcon(icon: IconOption,
                                  size: CGSize = CGSize(width: 20, height: 20),
                                  color: Color = .blue) -> some View {
        Image(systemName: icon.rawValue)
            .resizable()
            .frame(width: size.width, height: size.height)
            .scaledToFit()
            .foregroundStyle(color)
    }
}

extension PSLiveActivityAttributes {
    fileprivate static var preview: PSLiveActivityAttributes {
        PSLiveActivityAttributes(name: "World")
    }
}

extension PSLiveActivityAttributes.ContentState {
    fileprivate static var smiley: PSLiveActivityAttributes.ContentState {
        PSLiveActivityAttributes.ContentState(emoji: "😀")
     }
}

#Preview("Expanded", as: .dynamicIsland(.expanded), using: PSLiveActivityAttributes.preview) {
   PureSipWidgetLiveActivity()
} contentStates: {
    PSLiveActivityAttributes.ContentState.smiley
}

#Preview("Compact", as: .dynamicIsland(.compact), using: PSLiveActivityAttributes.preview) {
   PureSipWidgetLiveActivity()
} contentStates: {
    PSLiveActivityAttributes.ContentState.smiley
}

#Preview("Minimal", as: .dynamicIsland(.minimal), using: PSLiveActivityAttributes.preview) {
   PureSipWidgetLiveActivity()
} contentStates: {
    PSLiveActivityAttributes.ContentState.smiley
}


