//
//  AppDelegate.swift
//  mudo
//
//  Created by Brett Bauman on 3/12/22.
//

import Foundation
import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    weak var deeplinkRouter: DeeplinkRouter?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        deeplinkRouter?.isMoodEditorPresented = true
    }
}

class DeeplinkRouter: ObservableObject {
    
    @Published var isMoodEditorPresented = false
}
