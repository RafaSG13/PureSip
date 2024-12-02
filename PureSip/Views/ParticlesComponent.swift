//
//  ParticlesView.swift
//  RSGDesignSystem
//
//  Created by Rafael Serrano Gamarra on 14/8/24.
//

import SwiftUI

public struct ParticlesComponent: View {
    var particlesColor: Color = .white

    public var body: some View {
        ZStack {
            Circle()
                .fill(particlesColor.opacity(0.2))
                .frame(width: 40, height: 40)
                .offset(x: -80, y: 100)
            Circle()
                .fill(particlesColor.opacity(0.2))
                .frame(width: 10, height: 10)
                .offset(x: -50, y: -100)
            Circle()
                .fill(particlesColor.opacity(0.2))
                .frame(width: 20, height: 20)
                .offset(x: 70, y: 50)
            Circle()
                .fill(particlesColor.opacity(0.2))
                .frame(width: 10, height: 10)
                .offset(x: 110, y: 100)
            Circle()
                .fill(particlesColor.opacity(0.2))
                .frame(width: 80, height: 80)
                .offset(x: 50, y: 150)
        }
    }
}
