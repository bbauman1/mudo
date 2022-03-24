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
    @Published var shouldShowPermissionsPrompt: Bool = false
    
    private var subscriptions = Subscriptions()
    
    init(entry: HistoryEntry, healthStore: HealthStore) {
        self.entry = entry
        self.healthStore = healthStore
        
        let hasRequestedHealthPermissions = UserDefaults.standard.publisher(for: \.hasRequestedHealthPermissions)
        Publishers.CombineLatest($healthEntries, $workoutEntries).combineLatest(hasRequestedHealthPermissions)
            .map { $0.0.0.isEmpty && $0.0.1.isEmpty && $0.1}
            .receive(on: DispatchQueue.main)
            .assign(to: &$shouldShowEmptyState)
        
        hasRequestedHealthPermissions
            .map { !$0 }
            .receive(on: DispatchQueue.main)
            .assign(to: &$shouldShowPermissionsPrompt)
    }
    
    func onAppear() {
        let hasMadeUserInitiatedPermissionsRequest = UserDefaults.standard.hasRequestedHealthPermissions
        if hasMadeUserInitiatedPermissionsRequest {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.healthStore.requestPermissions()
            }
        }
        
        bindHealthStore()
        
        let interval: TimeInterval = hasMadeUserInitiatedPermissionsRequest ? 5 : 1
        Timer.publish(every: interval, on: .main, in: .default)
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
    
    func requestInitialPermissions() {
        healthStore.requestPermissions()
        
        // delay to let health permissions present
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UserDefaults.standard.hasRequestedHealthPermissions = true
        }
    }
}

private extension UserDefaults {
    
    @objc var hasRequestedHealthPermissions: Bool {
        get { bool(forKey: "hasRequestedHealthPermissions") }
        set { set(newValue, forKey: "hasRequestedHealthPermissions") }
    }
}
