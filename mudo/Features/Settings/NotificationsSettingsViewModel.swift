//
//  NotificationsSettingsViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Combine
import UserNotifications
import Foundation

class NotificationsSettingsViewModel: ObservableObject {
    
    @Published var isNotificationsToggleOn: Bool = false
    @Published var showNotificationSettingsAlert: Bool = false
    @Published var notificationDate: Date = UserDefaults.standard.notificationDate
    
    private let notificationIdentifier = "mudoRecurring"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            await updateToggle()
            setUpObservers()
        }
    }
    
    func setUpObservers() {
        $isNotificationsToggleOn
            .dropFirst()
            .sink { [self] isOn in
                UserDefaults.standard.isNotificationsToggleOn = isOn
                if isOn {
                    requestPermissionsIfNeeded()
                } else {
                    cancelPendingNotifications()
                }
            }
            .store(in: &cancellables)
        
        $notificationDate
            .sink { date in
                UserDefaults.standard.notificationDate = date
                self.scheduleRecurringNotifications() }
            .store(in: &cancellables)
    }
    
    private func scheduleRecurringNotifications() {
        cancelPendingNotifications()
        
        let content = UNMutableNotificationContent()
        content.title = "How ya feeling?"
        content.body = "Time to record your mood for the day"
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: notificationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notifications \(error)")
            } else {
                print("Notifications scheduled for \(dateComponents.hour ?? 0):\(dateComponents.minute ?? 0)")
            }
        }
    }
    
    private func cancelPendingNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    }
    
    private func updateToggle() async {
        let isSwitchOnByUser = UserDefaults.standard.isNotificationsToggleOn
        let isAuthorized = await isAuthorizedForNotifications()
        DispatchQueue.main.async {
            self.isNotificationsToggleOn = isSwitchOnByUser && isAuthorized
        }
    }
    
    private func requestPermissionsIfNeeded() {
        Task {
            let settings = await UNUserNotificationCenter.current().notificationSettings()
            switch settings.authorizationStatus {
            case .notDetermined:
                let granted = try? await UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .sound])
                if granted == true {
                    scheduleRecurringNotifications()
                } else {
                    isNotificationsToggleOn = false
                }
            case .denied:
                showNotificationSettingsAlert = true
                isNotificationsToggleOn = false
            case .ephemeral, .authorized, .provisional:
                break
            @unknown default:
                break
            }
        }
    }
    
    private func isAuthorizedForNotifications() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        switch settings.authorizationStatus {
        case .notDetermined, .denied:
            return false
        case .authorized, .provisional, .ephemeral:
            return true
        @unknown default:
            return false
        }
    }
}

private extension UserDefaults {
    
    var isNotificationsToggleOn: Bool {
        get { bool(forKey: "notificationsToggle") }
        set { set(newValue, forKey: "notificationsToggle")}
    }
    
    var notificationDate: Date {
        get {
            let timeInterval = double(forKey: "notificationDate")
            if timeInterval != 0 {
                return Date(timeIntervalSince1970: timeInterval)
            } else {
                return Date()
            }
        }
        set {
            set(newValue.timeIntervalSince1970, forKey: "notificationDate")
        }
    }
}
