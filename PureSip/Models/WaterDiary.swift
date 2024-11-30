//
//  WaterDiary.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 27/8/24.
//

import Foundation
import SwiftData

@Model
class WaterDiary {
    @Attribute(.unique) let id: UUID = UUID()
    let day: Date
    let objetiveAmount: Double
    var waterIntake: Double
    
    var progress: Double {
        return min(waterIntake / objetiveAmount, 1.0)
    }

    init(day: Date, objetiveAmount: Double, waterIntake: Double) {
        self.day = day
        self.objetiveAmount = objetiveAmount
        self.waterIntake = waterIntake
    }
}
