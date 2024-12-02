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

    init(glassSize: GlassSize) {
        self.glassSize = glassSize.rawValue
    }

    /// This initializer is required to conform to  the `AppIntent` protocol and should not be used directly.
    init() { self.glassSize = 0 }
    
    static var title: LocalizedStringResource = "Update Progress"

    @Parameter(title: "Glass size")
    var glassSize: Double

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
            existingDiary.waterIntake += glassSize
            modelContext.insert(existingDiary)
            try modelContext.save()
        } else {
            let newDiary = WaterDiary(day: Date(), objetiveAmount: 3, waterIntake: glassSize)
            modelContext.insert(newDiary)
            try modelContext.save()
        }
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}

