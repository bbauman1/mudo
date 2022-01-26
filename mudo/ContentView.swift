//
//  ContentView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("appColor") var appColor: AppColor = .default
    @State var isSplashScreenFinished: Bool = false
    
    let moodStore = MoodStore()
    
    var body: some View {
        if isSplashScreenFinished {
            MudoView(viewModel: .init(moodStore: moodStore))
                .accentColor(appColor.color)
                .tint(appColor.color)
        } else {
            splashScreen
        }
    }
    
    var splashScreen: some View {
        Text("mudo (wip)")
            .font(.system(size: 36, weight: .bold, design: .rounded))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        isSplashScreenFinished = true
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
