//
//  WaterDropView.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 14/8/24.
//

import SharedModels
import SwiftUI
import SwiftData

public struct WaterDropView: View {
    @Environment(\.modelContext) var modelContext
    @State var waterDiary: WaterDiary?
    @State var progress: CGFloat = 0.0
    
    var backgroundColor: Color = .white
    var waterColor: Color = .blue

    enum Viewtraits {
        static let waterDropSize: CGSize = .init(width: UIScreen.main.bounds.size.width * 0.9,
                                                 height: UIScreen.main.bounds.size.width * 0.7)
        static let waveHeight: CGFloat = 0.02
        static let verticalOffset: CGFloat = -5
    }
    
    public var body: some View {
        let size = UIScreen.main.bounds.size
        
        ZStack {
            Color("IndigoBlue")
                .ignoresSafeArea()
            VStack {
                WaterDropComponent(size: size,
                                   tint: .blue,
                                   backgroundColor: .white,
                                   waveHeight: Viewtraits.waveHeight,
                                   verticalOffset: Viewtraits.verticalOffset,
                                   progress: $progress)
                AddGlassButton(size: size)
            }
         WaterDropLabel
        }
        .task {
            fetchWaterDiaryInfo()
        }
    }

    func fetchWaterDiaryInfo() {
        do {
            let startOfDay = Calendar.current.startOfDay(for: Date())
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!

            let descriptor = FetchDescriptor<WaterDiary>(
                predicate: #Predicate {
                    $0.day >= startOfDay && $0.day < endOfDay
                }
            )
            if let existingDiary = try modelContext.fetch(descriptor).first {
                self.waterDiary = existingDiary
                self.progress = existingDiary.progress
            } else {
                let newDiary = WaterDiary(day: Date(), objetiveAmount: 3, waterIntake: 0)
                modelContext.insert(newDiary)
                try modelContext.save()
                self.waterDiary = newDiary
                self.progress = newDiary.progress
            }
        } catch {
            print("Error fetching or creating WaterDiary: \(error)")
        }
    }

    func addGlass(size: GlassSize) {
        guard let waterDiary = self.waterDiary else { return }
        waterDiary.waterIntake += size.rawValue
        self.progress = waterDiary.progress
        modelContext.insert(waterDiary)
        try? modelContext.save()
    }
}

#Preview {
    WaterDropView()
}
