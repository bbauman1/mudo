//
//  HistoryEntry.swift
//  mudo
//
//  Created by Brett Bauman on 2/13/22.
//

import Foundation

struct HistoryEntry: Identifiable {
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