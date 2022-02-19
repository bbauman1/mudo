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
                note                
                ForEach(viewModel.healthEntries) {
                    HealthCardView(dataType: $0.dataType, value: $0.value)
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear(perform: viewModel.onAppear)
        .navigationTitle(entry.mood.emojiWithName)
    }
    
    var note: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "note.text")
                Text("Note")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
            }
            HStack {
                Text(entry.note)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Spacer()
            }
        }
        .padding()
        .multilineTextAlignment(.leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

class HistoryDetailViewModel: ObservableObject {
    
    let entry: HistoryEntry
    private let healthStore: HealthStore
    
    @Published var healthEntries: [HealthEntry] = HealthDataType.allCases.map { HealthEntry(dataType: $0, value: Double.random(in: 0...5000).rounded())}.sorted(by: { $0.dataType.displayPriority < $1.dataType.displayPriority })
    
    private var subscriptions = Subscriptions()
    
    init(entry: HistoryEntry, healthStore: HealthStore) {
        self.entry = entry
        self.healthStore = healthStore
        
//        Timer.publish(every: 5, on: .main, in: .common)
//            .autoconnect()
//            .sink { [weak self] _ in self?.bindHealthEntries() }
//            .store(in: &subscriptions)
    }
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.healthStore.requestPermissions()
        }
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
