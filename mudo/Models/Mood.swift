//
//  Mood.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation

enum Mood: CaseIterable, Codable {
    
    // MARK: Positive
    case happy
    case chillin
    case energized
    case graphUp
    case lucky
    case strong
    case fire
    case highEnergy
    case brain
    case spiritual
    case healthy
    case colorful
    case rocket
    case numberOne
    case inLove
    case rich
    case proud
    
    // MARK: Neutral
    case notSure
    case quiet
    case melted
    case hungry
    case empty
    case goofy
    case reportingForDuty
    case clairvoyant
    case groovy
    case fruity
    case royal
    case tropical
    case nostalgic
    case sloshed
    case cool
    case wildCard
    case anxious
    case tired
    
    // MARK: Negative
    case frantic
    case woozy
    case sick
    case disappointed
    case redacted
    case chains
    case dead
    case graphDown
    case loud
    case heartBroken
    case aggresive
    case shifty
    case strange
    case pain
    case frustrated
    case explosive
    case embarrased
    case annoyed
    case sad
    case scared
    case angry
    

    static var displayCases: [Mood] {
        if #available(iOS 15.4, *) {
            return allCases
        } else {
            return allCases.filter { !$0.requiresFifteenPointFour }
        }
        
//        let smileysAndPeople = allCases.filter { $0.moodType == .smileysAndPeople }
//        let other = allCases.filter { $0.moodType == .other }
//
//        return filterAndSort(smileysAndPeople) + filterAndSort(other)
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
        case .frantic:
            return "Frantic"
        case .empty:
            return "Empty"
        case .chillin:
            return "Chillin"
        case .woozy:
            return "Woozy"
        case .hungry:
            return "Hungry"
        case .disappointed:
            return "Disappointed"
        case .redacted:
            return "&$!#%"
        case .brain:
            return "200 IQ"
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
            return "Obedient"
        case .groovy:
            return "Groovy"
        case .fruity:
            return "Fruity"
        case .highEnergy:
            return "Activated"
        case .royal:
            return "Royal"
        case .nostalgic:
            return "Nostalgic"
        case .dead:
            return "Dead"
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
            return "Mixed"
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
        case .sloshed:
            return "Sloshed"
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
            return "🤒"
        case .frustrated:
            return "😣"
        case .frantic:
            return "😵‍💫"
        case .empty:
            return "🫥"
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
        case .sloshed:
            return "😳"
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
