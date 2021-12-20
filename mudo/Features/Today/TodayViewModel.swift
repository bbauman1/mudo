//
//  TodayViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Combine
import Foundation

class TodayViewModel: ObservableObject {
    
    @Published var mood: Mood?
    @Published var shouldShowRecordView: Bool = false
    
    private let moodStore: MoodStore
    
    init(moodStore: MoodStore) {
        self.moodStore = moodStore
        
        moodStore.isTodayRecorded
            .receive(on: DispatchQueue.main)
            .map { !$0 }
            .assign(to: &$shouldShowRecordView)
    }
    
    func recordMood() {
        guard let mood = mood else { return }        
        moodStore.store(mood)
    }
    
    func undoTodaysEntry() {
        moodStore.undoTodaysEntry()
    }
}
