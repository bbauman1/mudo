//
//  RootView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import HealthKit
import SwiftUI

struct RootView: View {
    
    @AppStorage("appColor") var appColor: AppColor = .default
    
    @State var isSplashScreenFinished: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.appThemeColor) var appThemeColor
    
    @ObservedObject var viewModel: MudoViewModel
    
    init(viewModel: MudoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if isSplashScreenFinished {
            MudoView(viewModel: viewModel)
                .environment(\.appThemeColor, appColor.color)
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
                Color(hex: 0xF9F9F9)
                    .ignoresSafeArea()
            }
            
            Text("mudo")
                .font(.custom("Takeover", size: 64))
                .foregroundColor(appColor.color)
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
