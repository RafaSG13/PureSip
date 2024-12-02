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
    @State var entry: PSWidgetEntry

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Image("PureSipLogo")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                Text("Daily Water Intake")
                    .foregroundStyle(.accent)
                    .font(.title2)
                    .bold()
                Spacer()
                Button(intent: ResetDailyProgressIntent()) {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .foregroundStyle(.white)
                }.buttonStyle(.borderless)
                Spacer()
            }
            HStack(spacing: 40) {
                glassSizeButton(size: .small)
                glassSizeButton(size: .medium)
                glassSizeButton(size: .large)
            }
            HorizontalProgressView(
                           size: CGSize(width: 300, height: 15),
                           backgroundColor: Color.gray.opacity(0.3),
                           progressColor: .accent,
                           progress: Binding(
                            get: { CGFloat(entry.progress) },
                            set: { entry.progress  = Double($0) }
                           )
                       )
            .overlay {
                Text("\(entry.progress.toPercentageString())")
                    .font(.caption)
                    .bold()
                    .italic()
                    .foregroundStyle(.widgetBackground)
            }
            .padding(.top, 10)
     
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
                    .frame(width: 50, height: 50)
                    .foregroundStyle(
                        Gradient(colors: [.black, .widgetBackground, .blue])
                    )
                    .shadow(color: .accent, radius: 5)
                Image(systemName: "mug")
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .foregroundStyle(.white)
                    .offset(x: 2)
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 9, height: 9)
                    .foregroundStyle(.white)
                    .bold()
            }
        }.buttonStyle(.borderless)
    }


//    private var meshGradient: some ShapeStyle {
//        MeshGradient(width: 3,
//                     height: 3,
//                     points: [
//                        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
//                        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
//                        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
//                     ],
//                     colors: [
//                        .black, .widgetBackground, .accent,
//                        .blue, .cyan, .blue,
//                        .accent, .cyan, .widgetBackground
//                     ])
//    }
}


#Preview(as: .systemMedium) {
    PureSipWidget()
} timeline: {
    PSWidgetEntry(date: .now)
}
