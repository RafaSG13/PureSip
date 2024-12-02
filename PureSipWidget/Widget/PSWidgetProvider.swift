//
//  PSProvider.swift
//  PureSipWidgetExtension
//
//  Created by Rafael Serrano Gamarra on 30/11/24.
//

import WidgetKit
import SwiftData
import SharedModels

struct PSWidgetProvider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (PSWidgetEntry) -> Void) {
        let entry = PSWidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PSWidgetEntry>) -> Void) {
        Task {
            do {
                let progress = try await fetchWaterDiaryProgress()
                let timeline = Timeline(entries: [PSWidgetEntry(date: .now, progress: progress)], policy: .never)
                completion(timeline)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func placeholder(in context: Context) -> PSWidgetEntry {
        PSWidgetEntry(date: .now, progress: 0.5)
    }

    @MainActor
    func fetchWaterDiaryProgress() async throws -> Double {
        let modelContext = SwiftDataModel.shared.modelContainer.mainContext

        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let descriptor = FetchDescriptor<WaterDiary>(
            predicate: #Predicate {
                $0.day >= startOfDay && $0.day < endOfDay
            }
        )
        if let existingDiary = try modelContext.fetch(descriptor).first {
            return existingDiary.progress
        } else {
            let newDiary = WaterDiary(day: Date(), objetiveAmount: 3, waterIntake: 0)
            modelContext.insert(newDiary)
            try modelContext.save()
            return 0
        }
    }
}
