//
//  WaterDropView+Components.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 30/11/24.
//

import SwiftUI

extension WaterDropView {

    @ViewBuilder
    var WaterDropLabel: some View {
        if progress == 1 {
            Image(systemName: "checkmark.seal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white)
                .frame(width: 80, height: 80)
                .bold()
        } else {
            Text(progress.toPercentageString())
                .foregroundStyle(progress >= 0.5 ? .white : .blue)
                .font(.largeTitle)
                .bold()
        }
    }

    @ViewBuilder
    func AddGlassButton(size: CGSize,
                                tint: Color = .blue,
                                backgroundColor: Color = .white) -> some View {
        ActionButton(actions: {
            FloatingAction(symbol: "plus", tint: tint, font: .title2, background: backgroundColor) {
                addGlass(size: .medium)
            }
            FloatingAction(symbol: "plus", tint: tint, font: .largeTitle, background: backgroundColor) {
                addGlass(size: .large)
            }
            FloatingAction(symbol: "plus", tint: tint, font: .caption, background: backgroundColor) {
                addGlass(size: .small)
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
