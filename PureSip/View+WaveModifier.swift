//
//  View+WaveModifier.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 13/8/24.
//

import SwiftUI

public extension View {
    func waveEffect(
        progress: CGFloat,
        wavesCount: Int = 3,
        animationDuration: TimeInterval = 2.0,
        waveFlexibility: Double = 0.1
    ) -> some View {
        modifier(
            WaveEffect(
                progress: progress,
                wavesCount: wavesCount,
                animationDuration: animationDuration,
                waveFlexibility: waveFlexibility
            ) {
                Color.blue.opacity(0.2 + Double($0) * 0.1)
            }
        )
    }
    
    func waveEffect<Style: ShapeStyle>(
        progress: CGFloat,
        wavesCount: Int = 3,
        animationDuration: TimeInterval = 2.0,
        waveFlexibility: Double = 0.1,
        fill: @escaping (Int) -> Style
    ) -> some View {
        modifier(
            WaveEffect(
                progress: progress,
                wavesCount: wavesCount,
                animationDuration: animationDuration,
                waveFlexibility: waveFlexibility,
                fill: fill
            )
        )
    }
}
