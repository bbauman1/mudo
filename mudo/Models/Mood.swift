//
//  Mood.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation

enum Mood: CaseIterable, Codable {
    case sleepy
    case frantic
    case empty
    case up
    case down
    case chillin
    case woozy
    case sick
    case hungry
    case disappointed
    case redacted
    case brain
    case chains
    case graphUp
    case graphDown
    case lucky
    case strong
    case goofy
    case reportingForDuty
    case groovy
    case fruity
    case highEnergy
    case royal
    case nostalgic
    case dead
    case bump
    case notSure
    case fire
    case spiritual
    case tropical
    case healthy
    case colorful
    case rocket
    case clairvoyant
    case melted
    case loud
    case numberOne
    case inLove
    case heartBroken
    case rich
    case aggresive
    case shifty
    case cool
    case strange
    case pain
    case wildCard
    case frustrated
    case explosive
    case energized
    case happy
    case embarrased
    case quiet
    case proud
    case tired
    case annoyed
    case sad
    case scared
    case angry
    case anxious

    static var displayCases: [Mood] {
        let smileysAndPeople = allCases.filter { $0.moodType == .smileysAndPeople }
        let other = allCases.filter { $0.moodType == .other }
        
        return filterAndSort(smileysAndPeople) + filterAndSort(other)
    }
    
    private static func filterAndSort(_ moods: [Mood]) -> [Mood] {
        var moods = moods
        
        if #available(iOS 15.4, *) {
            // #unavailable when i upgrade
        } else {
            moods = moods.filter { !$0.requiresFifteenPointFour }
        }
        
        moods = moods.sorted(by: { $0.displayName < $1.displayName })
        
        return moods
    }
}

extension Mood {
    
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
        case .sleepy:
            return "Sleepy"
        case .frantic:
            return "Frantic"
        case .empty:
            return "Empty"
        case .up:
            return "Up"
        case .down:
            return "Down"
        case .chillin:
            return "Chillin"
        case .woozy:
            return "Woozy"
        case .hungry:
            return "Hungry"
        case .disappointed:
            return "Disappointed"
        case .redacted:
            return "Redacted"
        case .brain:
            return "Brain"
        case .chains:
            return "Restricted"
        case .graphUp:
            return "Trending up"
        case .graphDown:
            return "Trending down"
        case .lucky:
            return "Lucky"
        case .strong:
            return "Strong"
        case .goofy:
            return "Goofy"
        case .reportingForDuty:
            return "Reporting for duty"
        case .groovy:
            return "Groovy"
        case .fruity:
            return "Fruity"
        case .highEnergy:
            return "High energy"
        case .royal:
            return "Royal"
        case .nostalgic:
            return "Nostalgic"
        case .dead:
            return "Dead"
        case .bump:
            return "Bump"
        case .notSure:
            return "Not sure"
        case .fire:
            return "Fire"
        case .spiritual:
            return "Spiritual"
        case .tropical:
            return "Tropical"
        case .healthy:
            return "Healthy"
        case .colorful:
            return "Colorful"
        case .rocket:
            return "Hodl"
        case .clairvoyant:
            return "Clairvoyant"
        case .melted:
            return "Melted"
        case .loud:
            return "Loud"
        case .numberOne:
            return "Number 1"
        case .inLove:
            return "In love"
        case .heartBroken:
            return "Heartbroken"
        case .rich:
            return "Rich"
        case .aggresive:
            return "Aggresive"
        case .shifty:
            return "Shifty"
        case .cool:
            return "Cool"
        case .strange:
            return "Strange"
        case .pain:
            return "Pain"
        case .wildCard:
            return "Wildcard"
        case .explosive:
            return "Explosive"
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
        case .sleepy:
            return "😴"
        case .frantic:
            return "😵‍💫"
        case .empty:
            return "🫥"
        case .up:
            return "👍"
        case .down:
            return "👎"
        case .chillin:
            return "🤙"
        case .woozy:
            return "🥴"
        case .hungry:
            return "😋"
        case .disappointed:
            return "😞"
        case .redacted:
            return "🤬"
        case .brain:
            return "🧠"
        case .chains:
            return "⛓️"
        case .graphUp:
            return "📈"
        case .graphDown:
            return "📉"
        case .lucky:
            return "🎰"
        case .strong:
            return "💪"
        case .goofy:
            return "🤡"
        case .reportingForDuty:
            return "🫡"
        case .groovy:
            return "🪩"
        case .fruity:
            return "🍆"
        case .highEnergy:
            return "⚡"
        case .royal:
            return "👑"
        case .nostalgic:
            return "💾"
        case .dead:
            return "🧟"
        case .bump:
            return "👊"
        case .notSure:
            return "🤷"
        case .fire:
            return "🔥"
        case .spiritual:
            return "🍄"
        case .tropical:
            return "🏝️"
        case .healthy:
            return "🥦"
        case .colorful:
            return "🌈"
        case .rocket:
            return "🚀"
        case .clairvoyant:
            return "🔮"
        case .melted:
            return "🫠"
        case .loud:
            return "📣"
        case .numberOne:
            return "🥇"
        case .inLove:
            return "❤️"
        case .heartBroken:
            return "💔"
        case .rich:
            return "💰"
        case .aggresive:
            return "🔫"
        case .shifty:
            return "👀"
        case .cool:
            return "🆒"
        case .strange:
            return "👽"
        case .pain:
            return "🥹"
        case .wildCard:
            return "🃏"
        case .explosive:
            return "💣"
        }
    }

    var emojiWithName: String {
        emoji + " " + displayName
    }
    
    var requiresFifteenPointFour: Bool {
        switch self {
        case .empty, .reportingForDuty, .groovy, .melted, .pain:
            return true
        default:
            return false
        }
    }
    
    var moodType: MoodType {
        switch self {
        case
            .redacted,
            .brain,
            .chains,
            .graphUp,
            .graphDown,
            .lucky,
            .goofy,
            .groovy,
            .fruity,
            .highEnergy,
            .royal,
            .nostalgic,
            .dead,
            .fire,
            .spiritual,
            .tropical,
            .healthy,
            .colorful,
            .rocket,
            .clairvoyant,
            .loud,
            .numberOne,
            .inLove,
            .heartBroken,
            .rich,
            .aggresive,
            .cool,
            .strange,
            .wildCard,
            .explosive:
            return .other
        default:
            return .smileysAndPeople
        }
    }
}

enum MoodType {
    case smileysAndPeople
    case other
}
