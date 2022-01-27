//
//  SettingsView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("appColor") var appColor: AppColor = .default
    
    @StateObject var notificationsViewModel = NotificationsSettingsViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                notificationsSection
                appSection
                debugSection
            }
            .navigationTitle("Settings")
        }
    }
    
    var notificationsSection: some View {
        Section(header: Text("Notification settings")) {
            Toggle("Enable daily reminder", isOn: $notificationsViewModel.isNotificationsToggleOn)
            if notificationsViewModel.isNotificationsToggleOn {
                DatePicker(
                    "Reminder time",
                    selection: $notificationsViewModel.notificationDate,
                    displayedComponents: .hourAndMinute)
            }
        }
    }
    
    var appSection: some View {
        Section(header: Text("App settings")) {
            Picker(selection: $appColor) {
                ForEach(AppColor.allCases, id: \.rawValue) { appColor in
                    HStack {
                        Circle()
                            .fill(appColor.color)
                            .frame(width: 20, height: 20)
                        Text(appColor.rawValue.capitalized)
                    }
                    .tag(appColor)
                }
            } label: {
                Text("App theme")
            }
        }
    }
}

extension SettingsView {
    var debugSection: some View {
        Section(header: Text("Debug")) {
            Button {
                let store = MoodStore()
                for _ in 0..<5 {
                    let entry = makeRandomEntry()
                    store.storeAtEndOfHistory(entry.mood, note: entry.note)
                }
            } label: {
                Text("Add 5 fake days to history")
            }
            
            Button {
                MoodStore().removeAll()
            } label: {
                Text("Delete history")
            }
            
            Button {
                MoodStore().annieBackup()
            } label: {
                Text("Backup annie's data")
            }
        }
    }
    
    private func makeRandomEntry() -> (mood: Mood, note: String) {
        let mood = Mood.allCases.randomElement()!
        let note = ["scoop", "poop", "doop", "loop", "boop"].randomElement()!
        return (mood, note)
    }
}
