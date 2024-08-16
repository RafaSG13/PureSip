//
//  PureSipApp.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 13/8/24.
//

import SwiftUI

@main
struct PureSipApp: App {
    var body: some Scene {
        WindowGroup {
            WaterDropView(vm: WaterProgressViewModel(objetive: 2),
                          backgroundColor: .white,
                          waterColor: .blue)
        }
    }
}
