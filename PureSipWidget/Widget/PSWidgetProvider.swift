//
//  PSProvider.swift
//  PureSipWidgetExtension
//
//  Created by Rafael Serrano Gamarra on 30/11/24.
//

import WidgetKit

struct PSWidgetProvider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (PSWidgetEntry) -> Void) {
        let entry = PSWidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PSWidgetEntry>) -> Void) {
        let timeline = Timeline(entries: [PSWidgetEntry(date: .now)], policy: .atEnd)
        completion(timeline)
    }

    func placeholder(in context: Context) -> PSWidgetEntry {
        PSWidgetEntry(date: .now, progress: 0.5)
    }
}
