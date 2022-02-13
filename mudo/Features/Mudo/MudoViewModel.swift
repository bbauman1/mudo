//
//  MudoViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 1/24/22.
//

import Foundation
import HealthKit

class MudoViewModel: ObservableObject {
    
    @Published var state: State = .empty
    
    private let moodStore: MoodStore
    private let healthStore: HKHealthStore
    
    private var subscriptions = Subscriptions()
    
    init(moodStore: MoodStore, healthStore: HKHealthStore) {
        self.moodStore = moodStore
        self.healthStore = healthStore
        
        moodStore.history
            .map(\.isEmpty)
            .sink { [weak self] isEmpty in
                self?.state = isEmpty ? .empty : .populated
            }
            .store(in: &subscriptions)
    }
    
    func makeMoodEditorViewModel() -> MoodEditorViewModel {
        MoodEditorViewModel(moodStore: moodStore)
    }
    
    func makeHistoryViewModel() -> HistoryViewModel {
        HistoryViewModel(moodStore: moodStore, healthStore: healthStore)
    }
}

extension MudoViewModel {
    enum State {
        case empty
        case populated
    }
}
