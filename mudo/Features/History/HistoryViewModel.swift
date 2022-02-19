//
//  HistoryViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation
import Combine

class HistoryViewModel: ObservableObject {
    
    @Published var history: [HistoryEntry] = []
    
    private let healthStore: HealthStore
    
    init(moodStore: MoodStore, healthStore: HealthStore) {
        self.healthStore = healthStore
        
        moodStore.history
            .map { $0.map(HistoryEntry.init) }
            .receive(on: DispatchQueue.main)
            .assign(to: &$history)
    }
    
    func makeDetailViewModel(for entry: HistoryEntry) -> HistoryDetailViewModel {
        HistoryDetailViewModel(entry: entry, healthStore: healthStore)
    }
}
