//
//  ContentView.swift
//  sticky
//
//  Created by MyachinGarpix on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    let centerWidth = UIScreen.main.bounds.width / 2
    let centerHeight = UIScreen.main.bounds.height / 2
    
    @State var position = CGSize()
    var body: some View {
        Canvas { context, size in
            
            let circle = context.resolveSymbol(id: 0)!
            let shape = context.resolveSymbol(id: 1)!
            
            context.addFilter(.alphaThreshold(min: 0.6, color: .white))
            context.addFilter(.blur(radius: 10))
            
            context.drawLayer { context in
                context.draw(circle, at: .init(x: centerWidth, y: centerHeight))
                context.draw(shape, at: .init(x: centerWidth, y: centerHeight))
            }
            
        } symbols: {
            Rectangle()
                .frame(width: 150, height: 150)
                .tag(0)
            Circle()
                .frame(width: 150, height: 150)
                .tag(1)
                .offset(position)
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture()
                .onChanged({ value in
            position = value.translation
        })
                .onEnded({ _ in
                    withAnimation(.bouncy(extraBounce: 0.1)) {
                        position = CGSize()
                    }
                })
        )
        .background(.cyan)
    }
}

#Preview {
    ContentView()
}
