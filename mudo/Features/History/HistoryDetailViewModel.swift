//
//  HistoryDetailViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 2/20/22.
//

import Foundation
import Combine

class HistoryDetailViewModel: ObservableObject {
    
    let entry: HistoryEntry
    private let healthStore: HealthStore
    
    @Published var healthEntries: [HealthEntry] = []
    @Published var workoutEntries: [WorkoutEntry] = []
    @Published var shouldShowEmptyState: Bool = false
    
    private var subscriptions = Subscriptions()
    
    init(entry: HistoryEntry, healthStore: HealthStore) {
        self.entry = entry
        self.healthStore = healthStore
        
        Publishers.CombineLatest($healthEntries, $workoutEntries)
            .map { $0.isEmpty && $1.isEmpty }
            .receive(on: DispatchQueue.main)
            .assign(to: &$shouldShowEmptyState)
    }
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.healthStore.requestPermissions()
        }
        
        bindHealthStore()
        
        Timer.publish(every: 5, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in self?.bindHealthStore() }
            .store(in: &subscriptions)
    }
    
    func onDisappear() {
        subscriptions.forEach { $0.cancel() }
    }
    
    func bindHealthStore() {
        healthStore.entries(for: entry.date)
            .map { $0.filter { $0.value > 0 }}
            .map { $0.sorted(by: { $0.dataType.displayPriority < $1.dataType.displayPriority })}
            .receive(on: DispatchQueue.main)
            .assign(to: &$healthEntries)
        
        healthStore.workoutEntries(for: entry.date)
            .receive(on: DispatchQueue.main)
            .assign(to: &$workoutEntries)
    }
}
