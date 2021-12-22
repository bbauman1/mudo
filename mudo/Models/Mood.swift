//
//  Mood.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation

enum Mood: CaseIterable, Codable {
    case energized
    case relaxed
    case empty
    case anxious
    case irritable
}

extension Mood {
    var displayName: String {
        switch self {
        case .energized:
            return "Energized"
        case .relaxed:
            return "Relaxed"
        case .empty:
            return "Empty"
        case .anxious:
            return "Anxious"
        case .irritable:
            return "Irritable"
        }
    }
    
    var emoji: String {
        switch self {
        case .energized:
            return "🥳"
        case .relaxed:
            return "😎"
        case .empty:
            return "😶"
        case .anxious:
            return "😰"
        case .irritable:
            return "😠"
        }
    }
    
    var emojiWithName: String {
        emoji + " " + displayName
    }
    
    static var displayOrder: [[Mood]] {
        [
            [Mood.energized, .relaxed],
            [Mood.empty],
            [Mood.anxious, .irritable],
        ]
    }
}
