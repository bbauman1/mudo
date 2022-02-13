//
//  HistoryViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation
import Combine
import HealthKit

class HistoryViewModel: ObservableObject {
    
    @Published var history: [HistoryEntry] = []
    
    private let healthStore: HKHealthStore
    
    init(moodStore: MoodStore, healthStore: HKHealthStore) {
        self.healthStore = healthStore
        
        moodStore.history
            .map { $0.map(HistoryEntry.init) }
            .receive(on: DispatchQueue.main)
            .assign(to: &$history)
    }
}
