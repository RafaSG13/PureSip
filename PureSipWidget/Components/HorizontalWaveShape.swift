//
//  HorizontalWaveShape.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import SwiftUI

public struct HorizontalWaveShape: Shape {
    var progress: CGFloat
    var waveHeight: CGFloat
    var offset: CGFloat
    public var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()

        let progressHeight: CGFloat = (1 - progress) * rect.height
        let waveAmplitude = waveHeight * rect.height

        path.move(to: CGPoint(x: 0, y: progressHeight))

        for x in stride(from: 0, to: rect.width, by: 2) {
            let relativeX = x / rect.width
            let sine = sin(2 * .pi * relativeX + offset / rect.width * 2 * .pi)
            let y = progressHeight + sine * waveAmplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}
