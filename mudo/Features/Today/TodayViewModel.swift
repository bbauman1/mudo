//
//  TodayViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Combine
import Foundation
import UIKit

class TodayViewModel: ObservableObject {
    
    @Published private(set) var mood: Mood?
    @Published var shouldShowRecordView: Bool = true
    @Published var note: String = ""
    
    private let moodStore: MoodStore
    
    private let feedbackGenerator = UIImpactFeedbackGenerator()
    
    init(moodStore: MoodStore) {
        self.moodStore = moodStore
        
        moodStore.isTodayRecorded
            .receive(on: DispatchQueue.main)
            .map { !$0 }
            .assign(to: &$shouldShowRecordView)
    }
    
    func recordMood() {
        guard let mood = mood else { return }
        feedbackGenerator.impactOccurred(intensity: 0.75)
        moodStore.store(mood, note: note)
    }
    
    func selectMood(_ mood: Mood) {
        feedbackGenerator.impactOccurred(intensity: 0.75)
        self.mood = mood
    }
    
    func undoTodaysEntry() {
        feedbackGenerator.impactOccurred(intensity: 0.33)
        moodStore.undoTodaysEntry()
    }
    
    func impactOccurred() {
        feedbackGenerator.impactOccurred(intensity: 0.75)
    }
}
