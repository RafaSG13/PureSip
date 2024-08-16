//
//  WaterDropView.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 14/8/24.
//
import SwiftUI

public struct WaterDropView: View {
    @StateObject var vm: WaterProgressViewModel
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
                                   progress: $vm.progress)
                AddGlassButton(size: size)
            }
            if vm.progress >= 1 {
                Image(systemName: "checkmark.seal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 80)
                    .bold()
            } else {
                Text(vm.progress.toPercentageString())
                    .foregroundStyle(vm.progress >= 0.5 ? .white : .blue)
                    .font(.largeTitle)
                    .bold()
            }
        }
    }
    
    @ViewBuilder
    private func AddGlassButton(size: CGSize, tint: Color = .blue, backgroundColor: Color = .white) -> some View {
        ActionButton(actions: {
            FloatingAction(symbol: "eraser", tint: tint, font: .headline, background: backgroundColor) {
                vm.addWaterIntake(size: .medium)
            }
            FloatingAction(symbol: "pencil", tint: tint, font: .body, background: backgroundColor) {
                vm.addWaterIntake(size: .large)
            }
            FloatingAction(symbol: "smallcircle.filled.circle.fill", tint: tint, font: .body, background: backgroundColor) {
                vm.addWaterIntake(size: .small)
            }
        }, label: { isExpanded in
            Image(systemName: "plus")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(tint)
                .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                .scaleEffect(1.02)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor, in: .circle)
                .scaleEffect(isExpanded ? 0.9 : 1)
        }, buttonSize: size.width * 0.15)
        .offset(y: -35)
    }
}

#Preview {
    WaterDropView(vm: WaterProgressViewModel(objetive: 2),
                  backgroundColor: .cyan.opacity(0.3),
                  waterColor: .blue)
}
