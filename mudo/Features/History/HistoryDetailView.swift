//
//  HistoryDetailView.swift
//  mudo
//
//  Created by Brett Bauman on 12/22/21.
//

import SwiftUI

struct HistoryDetailView: View {
    
    @ObservedObject var viewModel: HistoryDetailViewModel
    
    var entry: HistoryEntry { viewModel.entry }
    
    var body: some View {
        ScrollView {
            Group {
                if !entry.note.isEmpty {
                    note
                }
                
                ForEach(viewModel.healthEntries) {
                    HealthCardView(dataType: $0.dataType, value: $0.value)
                }
                
                if viewModel.healthEntries.isEmpty {
                    healthPermissionsView
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
        .navigationTitle(entry.mood.emojiWithName)
    }
    
    var note: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "note.text")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Text("Note • " + entry.dateStringAbbreviated)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
            }
            HStack {
                Text(entry.note)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding()
        .multilineTextAlignment(.leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.accentColor)
        )
    }
    
    var healthPermissionsView: some View {
        VStack(alignment: .leading) {
            Text("No Apple Health data found for this day. Double check that your Apple Health permissions are enabled in Settings.")
                .font(.system(.callout))
            HStack {
                Spacer()
                Button("Open Settings") {
                    UIApplication.shared.open(
                        URL(string: UIApplication.openSettingsURLString)!,
                        options: [:],
                        completionHandler: nil)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

class HistoryDetailViewModel: ObservableObject {
    
    let entry: HistoryEntry
    private let healthStore: HealthStore
    
    @Published var healthEntries: [HealthEntry] = []
    
    private var subscriptions = Subscriptions()
    
    init(entry: HistoryEntry, healthStore: HealthStore) {
        self.entry = entry
        self.healthStore = healthStore
    }
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.healthStore.requestPermissions()
        }
        
        bindHealthEntries()
        
        Timer.publish(every: 5, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in self?.bindHealthEntries() }
            .store(in: &subscriptions)
    }
    
    func onDisappear() {
        subscriptions.forEach { $0.cancel() }
    }
    
    func bindHealthEntries() {
        healthStore.entries(for: entry.date)
            .map { $0.filter { $0.value > 0 }}
            .map { $0.sorted(by: { $0.dataType.displayPriority < $1.dataType.displayPriority })}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.healthEntries = $0 }
            .store(in: &subscriptions)
    }
}
