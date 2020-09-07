//
//  Loader.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

private struct Loader: View {
    @State private var isAnimating: Bool = false
    var body: some View {
        
        GeometryReader { (geometry) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(self.scaleEffect(forIndex: index))
                        .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                .animation(
                    Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                        .repeatForever(autoreverses: false)
                )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
    
    func scaleEffect(forIndex index:Int) -> CGFloat {
        return !self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5
    }
}

private struct LoadingView: ViewModifier {
    @Binding var isLoading:Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content.zIndex(1.0)
            if isLoading {
                loadingView
                    .animation(.easeInOut)
                    .zIndex(2.0)
                    .accessibility(identifier: "LoadingView")
            }
        }
    }
    
    var loadingView:some View {
        ZStack(alignment: .center) {
            VStack {
                Loader()
                    .frame(width: 50, height: 50)
            }
            .offset(x: 0, y: isLoading ? 0.0 : UIScreen.main.bounds.size.height)
            .animation(.spring())
        }
    }
}

extension View {
    func loadingIndicator(_ isLoading:Binding<Bool>) -> some View {
        return self.modifier(LoadingView(isLoading: isLoading))
    }
}
