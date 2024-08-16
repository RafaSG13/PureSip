//
//  WaterDropComponent.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 16/8/24.
//

import SwiftUI

struct WaterDropComponent: View {
    var size: CGSize
    var tint: Color
    var backgroundColor: Color
    var waveHeight: CGFloat
    var verticalOffset: CGFloat
    @Binding var progress: CGFloat
    var internalPadding: CGFloat = 20
    var animationDuration: CGFloat = 2
    @State private var startAnimation: CGFloat = .zero
    
    var body: some View {
        ZStack {
            Image(systemName: "drop.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(backgroundColor)
                .offset(x: 0, y: verticalOffset)
            
            WaveShape(progress: progress,
                      waveHeight: waveHeight,
                      offset: startAnimation)
            .fill(tint)
            .overlay {
                ParticlesComponent()
            }
            .mask {
                Image(systemName: "drop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(internalPadding)
            }
        }
        .frame(width: size.width * 0.9, height: size.height * 0.7)
        .onAppear {
            withAnimation(.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
                startAnimation = size.width
            }
        }
    }
}

#Preview {
    WaterDropComponent(size: UIScreen.main.bounds.size, tint: .blue, backgroundColor: .white, waveHeight: 0.02, verticalOffset: -5, progress: .constant(0.5), internalPadding: 20, animationDuration: 2)
        .background(.red)
}
