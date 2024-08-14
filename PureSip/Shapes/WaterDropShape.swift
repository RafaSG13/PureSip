//
//  WaterDropShape.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 14/8/24.
//

import Foundation
import SwiftUI

struct WaterDropShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Start at the top center of the drop
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))

        // Left curve
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.midY),
            control: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.2)
        )

        // Bottom curve left curve
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY ),
            control: CGPoint(x: rect.minX, y: rect.maxY)
        )
        
        // Bottom curve right curve
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY),
            control: CGPoint(x: rect.maxX, y: rect.maxY)
        )
        
        // Right curve
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.minY),
            control: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.2)
        )

        path.closeSubpath()
        return path
    }
}

struct Demo: View {
    var body: some View {
        WaterDropShape()
            .fill(LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                startPoint: .top,
                endPoint: .bottom
            ))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Demo()
    }
}
