//
//  MudoViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 1/24/22.
//

import Foundation

class MudoViewModel: ObservableObject {
    
    @Published var state: State = .empty
    @Published var recordButtonText: String = ""
    
    private let moodStore: MoodStore
    private let healthStore: HealthStore
    
    private var subscriptions = Subscriptions()
    
    init(moodStore: MoodStore, healthStore: HealthStore) {
        self.moodStore = moodStore
        self.healthStore = healthStore
        
        moodStore.history
            .map { $0.isEmpty ? State.empty : .populated }
            .assign(to: &$state)
        
        moodStore.isTodayRecorded
            .map { $0 ? "Edit todays mood" : "Record todays mood" }
            .assign(to: &$recordButtonText)
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
