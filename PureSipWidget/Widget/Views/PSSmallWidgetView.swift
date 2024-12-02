//
//  PSSmallWidgetView.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import SwiftUI
import WidgetKit

struct PSSmallWidgetView: View {
    @State var entry: PSWidgetEntry
    var body: some View {
        VStack {
            Text("Tap to add 💧")
                .font(.system(size: 15))
                .bold()
            Button(intent: UpdateProgressIntent(glassSize: .small)) {
                Image("PureSipLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(.circle)
                    .shadow(color: .accent, radius: 3)
            }
            .buttonStyle(.borderless)
            waterIntakeStatusView
                .padding(.top, 2)
        }
        .foregroundStyle(.accent)
        .padding()
    }

    @ViewBuilder var waterIntakeStatusView: some View {
        if entry.progress == 1 {
            Text("Completed")
                .font(.system(size: 15))
                .bold()
                .italic()
                .frame(width: 100)
        } else {
            HorizontalProgressView(size: .init(width: 100, height: 5),
                                   backgroundColor: .gray.opacity(0.3),
                                   progressColor: .accent,
                                   progress: Binding(
                                    get: { CGFloat(entry.progress) },
                                    set: { entry.progress  = Double($0) }
                                   ))
        }
    }
}

#Preview(as: .systemSmall) {
    PureSipWidget()
} timeline: {
    PSWidgetEntry(date: .now)
}

#Preview(as: .systemSmall) {
    PureSipWidget()
} timeline: {
    PSWidgetEntry(date: .now, progress: 1)
}
