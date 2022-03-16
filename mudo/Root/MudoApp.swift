//
//  mudoApp.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI
import HealthKit

@main
struct MudoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let viewModel = MudoViewModel(
        moodStore: MoodStore(),
        healthStore: HealthStore(hkHealthStore: HKHealthStore()),
        deeplinkRouter: DeeplinkRouter())
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: viewModel)
                .onAppear { appDelegate.deeplinkRouter = viewModel.deeplinkRouter }
        }
    }
}
