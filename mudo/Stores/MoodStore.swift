//
//  MoodStore.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Combine
import Foundation
import UIKit

class MoodStore {
    
    var history: AnyPublisher<LogHistory, Never> {
        // todo: figure out how to get publisher working for custom type instead of data
        let logHistory = UserDefaults.standard.publisher(for: \.logHistoryData)
            .map { _ in UserDefaults.standard.logHistory }
            .eraseToAnyPublisher()
        
        let appWillForeground = NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .map { _ in UserDefaults.standard.logHistory }
            .eraseToAnyPublisher()
        
        return Publishers.Merge(logHistory, appWillForeground)
            .eraseToAnyPublisher()
    }
    
    var isTodayRecorded: AnyPublisher<Bool, Never> {
        todaysEntry
            .map { $0 == nil }
            .eraseToAnyPublisher()
    }
    
    var mostRecentEntry: AnyPublisher<LogEntry?, Never> {
        history
            .map { $0.first }
            .eraseToAnyPublisher()
    }
    
    var todaysEntry: AnyPublisher<LogEntry?, Never> {
        mostRecentEntry
            .map {
                guard let entry = $0, Calendar.current.isDateInToday(entry.date) else {
                    return nil
                }
                
                return entry
            }
            .eraseToAnyPublisher()
    }
    
    func store(_ mood: Mood, note: String) {
        let entry = LogEntry(date: Date(), mood: mood, note: note)
        var history = UserDefaults.standard.logHistory
        
        if let previousEntry = history.first, Calendar.current.isDateInToday(previousEntry.date) {
            print("Error: Attempted to save mood for a day that is already recorded.")
            history.removeFirst()
        }
        
        history.insert(entry, at: 0)
        UserDefaults.standard.logHistory = history
    }
    
    func undoTodaysEntry() {
        let history = UserDefaults.standard.logHistory
        guard let mostRecentEntry = history.first, Calendar.current.isDateInToday(mostRecentEntry.date) else {
            return
        }
        UserDefaults.standard.logHistory = Array(history.dropFirst())
    }
}

extension MoodStore {
    func storeAtEndOfHistory(_ mood: Mood, note: String) {
        var history = UserDefaults.standard.logHistory
        
        let date: Date = {
            guard
                let lastStoredDate = history.last?.date,
                let date = Calendar.current.date(byAdding: .day, value: 1, to: lastStoredDate)
            else {
                return Date()
            }
            
            return date
        }()
        
        let entry = LogEntry(date: date, mood: mood, note: note)
        history.append(entry)
        UserDefaults.standard.logHistory = history
    }
    
    func removeAll() {
        UserDefaults.standard.logHistory = []
    }
}

private extension UserDefaults {
    var logHistory: LogHistory {
        get {
            guard let data = logHistoryData else { return [] }
            return (try? JSONDecoder().decode(LogHistory.self, from: data)) ?? []
        }
        set {
            let data = (try? JSONEncoder().encode(newValue)) ?? nil
            logHistoryData = data
        }
    }
    
    @objc var logHistoryData: Data? {
        get { data(forKey: "logHistory") }
        set { set(newValue, forKey: "logHistory") }
    }
}
