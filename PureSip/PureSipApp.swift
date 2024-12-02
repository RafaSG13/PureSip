//
//  PureSipApp.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 13/8/24.
//

import SharedModels
import SwiftUI
import SwiftData

@main
struct PureSipApp: App {
    var body: some Scene {
        WindowGroup {
            WaterDropView()
        }
        .modelContainer(SwiftDataModel.shared.modelContainer)
    }
}
