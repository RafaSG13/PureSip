//
//  WaterDiary.swift
//  Shared Models
//
//  Created by Rafael Serrano Gamarra on 27/8/24.
//

import Foundation
import SwiftData

@Model
public final class WaterDiary: Sendable {
    @Attribute(.unique)
    public var id: UUID = UUID()
    public var day: Date
    public var objetiveAmount: Double
    public var waterIntake: Double
    
    public var progress: Double {
        return min(waterIntake / objetiveAmount, 1.0)
    }

    public init(day: Date, objetiveAmount: Double, waterIntake: Double) {
        self.day = day
        self.objetiveAmount = objetiveAmount
        self.waterIntake = waterIntake
    }
}
