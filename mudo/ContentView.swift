//
//  ContentView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import HealthKit
import SwiftUI

struct ContentView: View {
    
    @AppStorage("appColor") var appColor: AppColor = .default
    @State var isSplashScreenFinished: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    let viewModel = MudoViewModel(moodStore: MoodStore(), healthStore: HKHealthStore())
    
    var body: some View {
        if isSplashScreenFinished {
            MudoView(viewModel: viewModel)
                .accentColor(appColor.color)
                .tint(appColor.color)
        } else {
            splashScreen
        }
    }
    
    var splashScreen: some View {
        ZStack {
            if colorScheme == .dark {
                Color.black
                    .ignoresSafeArea()
            } else {
                Color(hex: 0xfffff2)
                    .ignoresSafeArea()
            }
            
            Text("mudo")
                .font(.custom("Takeover", size: 64))
                .foregroundColor(appColor.color)
//                .foregroundColor(colorScheme == .dark ? Color(hex: 0xfffff2) : .black)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation {
                            isSplashScreenFinished = true
                        }
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
