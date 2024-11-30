//
//  UpdateProgressIntent.swift
//  SharedModels
//
//  Created by Rafael Serrano Gamarra on 7/11/24.
//

import Foundation
import AppIntents
import SharedModels
import WidgetKit

struct UpdateProgressIntent: AppIntent {
    static var title: LocalizedStringResource = "Update Progress"

    var glassSize: GlassSize = .small

    func perform() async throws -> some IntentResult {
        // Utilizar el parámetro glassSize aquí
        print("Selected glass size: \(glassSize)")
        
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}

