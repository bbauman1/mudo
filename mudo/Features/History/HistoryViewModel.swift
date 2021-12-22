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
            self.dateString = {
                let date = logEntry.date.formatted(.dateTime.month(.wide).day(.defaultDigits))
                let time = logEntry.date.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute(.defaultDigits))
                return date + " • " + time
            }()
            self.note = logEntry.note
        }
    }
}
