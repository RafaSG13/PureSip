//
//  PureSipWidget.swift
//  PureSipWidget
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import WidgetKit
import SwiftUI

struct PureSipWidget: Widget {
    let kind: String = "PureSipWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PSWidgetProvider()) { entry in
            PureSipWidgetEntryView(entry: entry)
                .containerBackground(.widgetBackground, for: .widget)
        }
        .supportedFamilies([.systemMedium, .systemSmall])
    }
}

// MARK: - Widget View for each family
struct PureSipWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: PSWidgetEntry

    var body: some View {
        widgetView
    }

    @ViewBuilder var widgetView: some View {
        if widgetFamily == .systemSmall {
            PSSmallWidgetView(entry: entry)
        } else {
            PSMediumWidgetView(entry: entry)
        }
    }
}

#Preview(as: .systemSmall) {
    PureSipWidget()
} timeline: {
    PSWidgetEntry(date: .now)
}

#Preview(as: .systemMedium) {
    PureSipWidget()
} timeline: {
    PSWidgetEntry(date: .now)
}
