//
//  UpdateProgressIntent.swift
//  SharedModels
//
//  Created by Rafael Serrano Gamarra on 7/11/24.
//

import Foundation
import AppIntents
import SharedModels
import SwiftData
import WidgetKit

struct UpdateProgressIntent: AppIntent {
    static var title: LocalizedStringResource = "Update Progress"

    var glassSize: GlassSize = .small

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
            existingDiary.waterIntake += glassSize.rawValue
            modelContext.insert(existingDiary)
            try modelContext.save()
//            modelContext.delete(existingDiary)
//            let newDiary = WaterDiary(day: Date(), objetiveAmount: 3, waterIntake: 0)
//            modelContext.insert(newDiary)
            try modelContext.save()
        } else {
            let newDiary = WaterDiary(day: Date(), objetiveAmount: 3, waterIntake: glassSize.rawValue)
            modelContext.insert(newDiary)
            try modelContext.save()
        }
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}

