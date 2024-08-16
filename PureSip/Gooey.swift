//
//  Gooey.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 16/8/24.
//

import SwiftUI

struct Gooey: View {
    let centerHeightView = UIScreen.main.bounds.height / 2
    let centerWidthView = UIScreen.main.bounds.width / 2
    
    @State var positionS = CGSize(width: 0, height: 0)
    @State var positionM = CGSize(width: 0, height: 0)
    @State var positionL = CGSize(width: 0, height: 0)
    
    var body: some View {
        Canvas { context, size in
            guard let mainButton = context.resolveSymbol(id: 0) else { return }
            guard let secondButton = context.resolveSymbol(id: 1) else { return }
            guard let thirdButton = context.resolveSymbol(id: 2) else { return }
            guard let fourthButton = context.resolveSymbol(id: 3) else { return }
            
            context.addFilter(.alphaThreshold(min: 0.3))
            context.addFilter(.blur(radius: 20))
            
            context.drawLayer { graphicsContext in
                graphicsContext.draw(mainButton, at: .init(x: centerWidthView, y: centerHeightView))
                graphicsContext.draw(secondButton, at: .init(x: centerWidthView, y: centerHeightView))
                graphicsContext.draw(thirdButton, at: .init(x: centerWidthView, y: centerHeightView))
                graphicsContext.draw(fourthButton, at: .init(x: centerWidthView, y: centerHeightView))
            }
            
        } symbols: {
            Circle()
                .fill(.blue)
                .frame(width: 60, height: 60)
                .tag(0)
            
            Circle()
                .fill(.yellow)
                .frame(width: 60, height: 60)
                .offset(x: positionS.width, y: positionS.height)
                .tag(1)
            
            Circle()
                .fill(.red)
                .frame(width: 60, height: 60)
                .offset(x: positionM.width, y: positionM.height)
                .tag(2)
            
            Circle()
                .frame(width: 60, height: 60)
                .offset(x: positionL.width, y: positionL.height)
                .tag(3)
            
        }
        .gesture(TapGesture().onEnded({ tap in
            withAnimation(.spring, {
                positionS.width +=  80
                positionS.height +=  80
                positionM.width -=  80
                positionM.height -=  80
            })
        }))

    }
}


#Preview {
    Gooey()
}
