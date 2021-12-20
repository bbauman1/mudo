//
//  SettingsView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct SettingsView: View {
        
    @State var appColor = AppColor.blue
    
    @StateObject var notificationsViewModel = NotificationsSettingsViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                notificationsSection
                appSection
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

enum AppColor: String, CaseIterable {
    case red
    case green
    case blue
    case pink
    
    var color: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .pink:
            return .pink
        }
    }
}

