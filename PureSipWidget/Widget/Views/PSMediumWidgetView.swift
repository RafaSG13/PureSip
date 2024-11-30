//
//  PSMediumWidgetView.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import AppIntents
import SharedModels
import SwiftUI
import WidgetKit

struct PSMediumWidgetView: View {
    var entry: PSWidgetEntry
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Image(systemName: "drop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.cyan)
                Spacer()
                Text("Daily Water Intake")
                    .foregroundStyle(.cyan)
                    .font(.title2)
                    .bold()
                Spacer()
            }
            HStack(spacing: 30) {
                glassSizeButton(size: .small)
                glassSizeButton(size: .medium)
                glassSizeButton(size: .large)
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .frame(height: 10)
                    .padding(.horizontal)
                HorizontalWaveShape(progress: 0.5,
                                    waveHeight: 0.02,
                                    offset: 0)
                .fill(.cyan)
                .mask {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 10)
                        .padding(.horizontal)
                }
            }
        }
    }
    
    
    @ViewBuilder
    func glassSizeButton(size: GlassSize) -> some View {
        let imageSize: CGSize = switch size {
        case .small: CGSize(width: 25, height: 25)
        case .medium: CGSize(width: 30, height: 30)
        case .large: CGSize(width: 35, height: 35)
        @unknown default: .zero
        }
        Button(intent: UpdateProgressIntent(glassSize: size)) {
            ZStack {
                Circle()
                    .stroke(.cyan, lineWidth: 2)
                    .shadow(color: .cyan, radius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.widgetBackground)
                Image(systemName: "mug")
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .foregroundStyle(.white)
                    .offset(x: 1.5)
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 9, height: 9)
                    .foregroundStyle(.white)
                    .bold()
            }
        }.buttonStyle(.plain)
    }
}


#Preview(as: .systemMedium) {
    PureSipWidget()
} timeline: {
    PSWidgetEntry(date: .now)
}
