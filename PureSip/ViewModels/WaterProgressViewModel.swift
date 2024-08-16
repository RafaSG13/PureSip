//
//  WaterProgressViewModel.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 14/8/24.
//

import Foundation
import SwiftUI

final class WaterProgressViewModel: ObservableObject {
    @Published var progress: CGFloat = 0.0
    private var objetive: CGFloat
    private var waterIntake: CGFloat = 0.0
    
    init(objetive: CGFloat) {
        self.objetive = objetive
    }
    
    func addWaterIntake(size: GlassSize) {
        waterIntake += size.rawValue
        updateProgress()
    }
    
    private func updateProgress() {
        guard objetive > 0 else { return }
        progress = waterIntake / objetive
    }
}
