//
//  SettingsView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var notificationsViewModel = NotificationsSettingsViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.appThemeColor) var appColor
    
    var body: some View {
        NavigationView {
            Form {
                notificationsSection
                appSection
                debugSection
            }
            .id(appColor)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
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
        Section(header: Text("App theme")) {
            AppThemePicker()
                .padding()
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
        }
    }
    
    private func makeRandomEntry() -> (mood: Mood, note: String) {
        let mood = Mood.allCases.randomElement()!
        let note = ["scoop", "poop", "doop", "loop", "boop"].randomElement()!
        return (mood, note)
    }
}
