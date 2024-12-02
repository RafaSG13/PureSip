//
//  HorizontalWaveShape.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import SwiftUI

public struct HorizontalWaveShape: Shape {
    var progress: CGFloat // Progreso (0.0 a 1.0)
    var waveHeight: CGFloat // Altura relativa de la onda
    var offset: CGFloat // Desplazamiento para animar la onda

    public var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()

        let progressWidth = progress * rect.width // Ancho proporcional al progreso
        let waveAmplitude = waveHeight * rect.height // Altura máxima de la onda

        path.move(to: .zero) // Comienza en la esquina superior izquierda

        for x in stride(from: 0, to: progressWidth, by: 2) {
            let relativeX = x / rect.width
            let sine = sin(2 * .pi * relativeX + offset)
            let y = rect.midY + sine * waveAmplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }

        // Cerrar el resto del rectángulo para rellenar
        path.addLine(to: CGPoint(x: progressWidth, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}

struct HorizontalProgressView: View {
    var size: CGSize
    var backgroundColor: Color
    var progressColor: Color
    var cornerRadius: CGFloat = 10 // Redondeo de las esquinas

    @Binding var progress: CGFloat // Progreso actual (0.0 a 1.0)

    var body: some View {
        ZStack(alignment: .leading) {
            // Fondo
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .frame(width: size.width, height: size.height)

            // Progreso
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(progressColor)
                .frame(width: size.width * progress, height: size.height)
                .animation(.easeInOut(duration: 0.5), value: progress) // Animación del progreso
        }
    }
}
