//
//  MudoViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 1/24/22.
//

import Foundation

class MudoViewModel: ObservableObject {
    
    @Published var state: State = .empty
    
    private let moodStore: MoodStore
    
    private var subscriptions = Subscriptions()
    
    init(moodStore: MoodStore) {
        self.moodStore = moodStore
        
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
        HistoryViewModel(moodStore: moodStore)
    }
}

extension MudoViewModel {
    enum State {
        case empty
        case populated
    }
}
