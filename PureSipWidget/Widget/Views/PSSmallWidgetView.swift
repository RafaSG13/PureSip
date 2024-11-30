//
//  PSSmallWidgetView.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import SwiftUI
import WidgetKit

struct PSSmallWidgetView: View {
    var entry: PSWidgetEntry
    var body: some View {
        VStack {
            Button {
                //Hacer una llamada a red o a local que almacene la info nueva de la intake
                // coredata.save(newProgress)
                WidgetCenter.shared.reloadAllTimelines()
            } label: {
                ZStack {
                    Image(systemName: "drop.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.cyan)
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                        .offset(y: 3)
                }
            }
            
            Text("\(Int(entry.progress * 100))%")
                .font(.title3)
                .bold()
                .italic()
                .foregroundStyle(.cyan)
        }.padding()
    }
}
