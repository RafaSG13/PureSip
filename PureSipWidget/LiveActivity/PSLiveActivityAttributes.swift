//
//  PSLiveActivityAttributes.swift
//  PureSipWidgetExtension
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct PSLiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
