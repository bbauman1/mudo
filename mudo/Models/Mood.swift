//
//  Mood.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation

enum Mood: CaseIterable, Codable {
    // MARK: Positive
    case energized
    case happy
    case embarrased
    case quiet
    case proud
    case tired
    
    // MARK: Negative
    case annoyed
    case sad
    case scared
    case angry
    case sick
    case frustrated
    case anxious
}

extension Mood {
    static var displayOrder: [[Mood]] {
        [
            [.energized, .happy, .embarrased, .quiet, .proud, .tired],
            [.annoyed, .sad, .scared, .angry, .sick, frustrated, anxious],
        ]
    }
    
    var displayName: String {
        switch self {
        case .energized:
            return "Energized"
        case .happy:
            return "Happy"
        case .embarrased:
            return "Embarrased"
        case .scared:
            return "Scared"
        case .quiet:
            return "Quiet"
        case .proud:
            return "Proud"
        case .annoyed:
            return "Annoyed"
        case .sad:
            return "Sad"
        case .tired:
            return "Tired"
        case .angry:
            return "Angry"
        case .sick:
            return "Sick"
        case .frustrated:
            return "Frustrated"
        case .anxious:
            return "Anxious"
        }
    }
    
    var emoji: String {
        switch self {
        case .energized:
            return "🥳"
        case .anxious:
            return "😰"
        case .happy:
            return "😄"
        case .embarrased:
            return "😳"
        case .quiet:
            return "😶"
        case .proud:
            return "😏"
        case .tired:
            return "😴"
        case .annoyed:
            return "😑"
        case .sad:
            return "😢"
        case .scared:
            return "😱"
        case .angry:
            return "😡"
        case .sick:
            return "😷"
        case .frustrated:
            return "😣"
        }
    }
    
    var emojiWithName: String {
        emoji + " " + displayName
    }
}
