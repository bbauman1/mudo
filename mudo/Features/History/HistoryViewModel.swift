//
//  HistoryViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation
import Combine

class HistoryViewModel: ObservableObject {
    
    @Published var history: [Entry] = []
    
    init(moodStore: MoodStore) {
        moodStore.history
            .map { $0.map(Entry.init) }
            .receive(on: DispatchQueue.main)
            .assign(to: &$history)
    }
    
}

extension HistoryViewModel {
    struct Entry: Identifiable {
        let id = UUID()
        let mood: Mood
        let dateString: String
        let note: String
        
        init(from logEntry: LogEntry) {
            self.mood = logEntry.mood
            self.dateString = logEntry.date.formatted(.dateTime)
            self.note = logEntry.note
        }
    }
}
