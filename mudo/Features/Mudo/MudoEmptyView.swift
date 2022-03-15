//
//  MudoEmptyView.swift
//  mudo
//
//  Created by Brett Bauman on 3/12/22.
//

import SwiftUI

struct MudoEmptyView: View {
    
    @State var isAnimating = false
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ForEach(0..<3) { _ in
                Rectangle()
                    .fill(
                        AngularGradient(
                            gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
                            center: .center))
                    .frame(width: 400, height: 300)
                    .mask(button.blur(radius: 20))
                    .scaleEffect(isAnimating ? 1.2 : 1)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
            }
            
            button
        }
        .onAppear { isAnimating = true }
    }
    
    var button: some View {
        Button {
            action()
        } label: {
            Text("record your first mood")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .padding()
                .foregroundColor(.white)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(.black)
    }
}

