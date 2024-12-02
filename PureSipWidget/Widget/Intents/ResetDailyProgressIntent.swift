//
//  ResetDailyProgressIntent.swift
//  SharedModels
//
//  Created by Rafael Serrano Gamarra on 2/12/24.
//

import AppIntents
import SwiftData
import SharedModels
import WidgetKit

struct ResetDailyProgressIntent: AppIntent {
    static var title: LocalizedStringResource = "Reset daily progress"

    @MainActor
    func perform() async throws -> some IntentResult {
        let modelContext = SwiftDataModel.shared.modelContainer.mainContext
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let descriptor = FetchDescriptor<WaterDiary>(
            predicate: #Predicate {
                $0.day >= startOfDay && $0.day < endOfDay
            }
        )
        if let existingDiary = try modelContext.fetch(descriptor).first {
            modelContext.delete(existingDiary)
            try modelContext.save()
        }
        return .result()
    }
}
