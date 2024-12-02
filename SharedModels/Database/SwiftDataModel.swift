//
//  SwiftDataModel.swift
//  SharedModels
//
//  Created by Rafael Serrano Gamarra on 2/12/24.
//

import SwiftData

public actor SwiftDataModel {
    public static let shared = SwiftDataModel()
    private init() {}
    
    public nonisolated lazy var modelContainer: ModelContainer = {
        let modelContainer: ModelContainer
        do {
            modelContainer = try ModelContainer(for: WaterDiary.self)
        } catch {
            fatalError("Failed to create the model container: \(error)")
        }
        return modelContainer
    }()
}
