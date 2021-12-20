//
//  LogEntry.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation

struct LogEntry: Codable {
    let date: Date
    let mood: Mood
}

typealias LogHistory = [LogEntry]
