//
//  HKWorkoutActivityType.swift
//  mudo
//
//  Created by Brett Bauman on 2/20/22.
//

import HealthKit

extension HKWorkoutActivityType {
    
    var displayName: String {
        switch self {
        case .americanFootball:
            return "American football"
        case .archery:
            return "Archery"
        case .australianFootball:
            return "Australian football"
        case .badminton:
            return "Badminton"
        case .baseball:
            return "Baseball"
        case .basketball:
            return "Basketball"
        case .bowling:
            return "Bowling"
        case .boxing:
            return "Boxing"
        case .climbing:
            return "Climbing"
        case .cricket:
            return "Cricket"
        case .crossTraining:
            return "Cross training"
        case .curling:
            return "Curling"
        case .cycling:
            return "Cycling"
        case .dance:
            return "Dance"
        case .danceInspiredTraining:
            return "Dance inspired training"
        case .elliptical:
            return "Elliptical"
        case .equestrianSports:
            return "Equestrian sports"
        case .fencing:
            return "Fencing"
        case .fishing:
            return "Fishing"
        case .functionalStrengthTraining:
            return "Functional strength training"
        case .golf:
            return "Golf"
        case .gymnastics:
            return "Gymnastics"
        case .handball:
            return "Handball"
        case .hiking:
            return "Hiking"
        case .hockey:
            return "Hockey"
        case .hunting:
            return "Hunting"
        case .lacrosse:
            return "Lacrosse"
        case .martialArts:
            return "Martial arts"
        case .mindAndBody:
            return "Mind and body"
        case .mixedMetabolicCardioTraining:
            return "Mixed metabolic cardio training"
        case .paddleSports:
            return "Paddle sports"
        case .play:
            return "Play"
        case .preparationAndRecovery:
            return "Preparation and recovery"
        case .racquetball:
            return "Racquetball"
        case .rowing:
            return "Rowing"
        case .rugby:
            return "Rugby"
        case .running:
            return "Running"
        case .sailing:
            return "Sailing"
        case .skatingSports:
            return "Skaing sports"
        case .snowSports:
            return "Snow sports"
        case .soccer:
            return "Soccer"
        case .softball:
            return "Softball"
        case .squash:
            return "Squash"
        case .stairClimbing:
            return "Stair climbing"
        case .surfingSports:
            return "Surfing sports"
        case .swimming:
            return "Swimming"
        case .tableTennis:
            return "Table tennis"
        case .tennis:
            return "Tennis"
        case .trackAndField:
            return "Track and field"
        case .traditionalStrengthTraining:
            return "Traditional strength training"
        case .volleyball:
            return "Volleyball"
        case .walking:
            return "Walking"
        case .waterFitness:
            return "Water fitness"
        case .waterPolo:
            return "Water polo"
        case .waterSports:
            return "Water sports"
        case .wrestling:
            return "Wrestling"
        case .yoga:
            return "Yoga"
        case .barre:
            return "Barre"
        case .coreTraining:
            return "Core training"
        case .crossCountrySkiing:
            return "Cross country skiing"
        case .downhillSkiing:
            return "Downhill skiing"
        case .flexibility:
            return "Flexibility"
        case .highIntensityIntervalTraining:
            return "High intensity interval training"
        case .jumpRope:
            return "Jump rope"
        case .kickboxing:
            return "Kickboxing"
        case .pilates:
            return "Pilates"
        case .snowboarding:
            return "Snowboarding"
        case .stairs:
            return "Stairs"
        case .stepTraining:
            return "Step training"
        case .wheelchairWalkPace:
            return "Wheelchair walk pace"
        case .wheelchairRunPace:
            return "Wheelchair run pace"
        case .taiChi:
            return "Tai chi"
        case .mixedCardio:
            return "Mixed cardio"
        case .handCycling:
            return "Hand cycling"
        case .discSports:
            return "Disc sports"
        case .fitnessGaming:
            return "Fitness gaming"
        case .cardioDance:
            return "Cardio dance"
        case .socialDance:
            return "Social dance"
        case .pickleball:
            return "Pickleball"
        case .cooldown:
            return "Cooldown"
        case .other:
            return "Other"
        @unknown default:
            return "Unknown workout type"
        }
    }
}
