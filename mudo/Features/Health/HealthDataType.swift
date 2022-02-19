//
//  HealthDataType.swift
//  mudo
//
//  Created by Brett Bauman on 2/13/22.
//

import Foundation
import HealthKit

enum HealthDataType: Int, CaseIterable {
    case stepCount
    case exerciseTime
    case standTime
    case activeEnergyBurned
    case distanceWalkingRunning
    case distanceCycling
    case distanceSwimming
    case distanceDownhillSnowSports
    case distanceWheelchair
}

// MARK: Display Properties

extension HealthDataType {
    var symbolName: String {
        switch self {
        case .stepCount:
            return "figure.walk.circle.fill"
        case .exerciseTime:
            return "hourglass"
        case .standTime:
            return "figure.stand"
        case .activeEnergyBurned:
            return "bolt.fill"
        case .distanceWalkingRunning:
            return "figure.walk"
        case .distanceCycling:
            return "bicycle"
        case .distanceSwimming:
            return "drop.fill"
        case .distanceDownhillSnowSports:
            return "snowflake"
        case .distanceWheelchair:
            return "figure.roll"
        }
    }
    
    var measurement: Measurement {
        switch self {
        case .stepCount:
            return .custom("steps")
        case .exerciseTime:
            return .time(.minutes)
        case .standTime:
            return .time(.hours)
        case .activeEnergyBurned:
            return .calories
        case .distanceWalkingRunning:
            return .distance
        case .distanceCycling:
            return .distance
        case .distanceSwimming:
            return .distance
        case .distanceDownhillSnowSports:
            return .distance
        case .distanceWheelchair:
            return .distance
        }
    }
    
    var displayName: String {
        switch self {
        case .stepCount:
            return "Step count"
        case .exerciseTime:
            return "Exercise time"
        case .standTime:
            return "Stand time"
        case .activeEnergyBurned:
            return "Active energy burned"
        case .distanceWalkingRunning:
            return "Distance walking and running"
        case .distanceCycling:
            return "Distance cycling"
        case .distanceSwimming:
            return "Distance swimming"
        case .distanceDownhillSnowSports:
            return "Distance skiing and snowboarding"
        case .distanceWheelchair:
            return "Distance by wheelchair"
        }
    }
    
    var displayPriority: Int {
        rawValue
    }
}

// MARK: HealthKit Properties

extension HealthDataType {
    var hkQuantityType: HKQuantityType {
        switch self {
        case .stepCount:
            return HKQuantityType(.stepCount)
        case .exerciseTime:
            return HKQuantityType(.appleExerciseTime)
        case .standTime:
            return HKQuantityType(.appleStandTime)
        case .activeEnergyBurned:
            return HKQuantityType(.activeEnergyBurned)
        case .distanceWalkingRunning:
            return HKQuantityType(.distanceWalkingRunning)
        case .distanceCycling:
            return HKQuantityType(.distanceCycling)
        case .distanceSwimming:
            return HKQuantityType(.distanceSwimming)
        case .distanceDownhillSnowSports:
            return HKQuantityType(.distanceDownhillSnowSports)
        case .distanceWheelchair:
            return HKQuantityType(.distanceWheelchair)
        }
    }
    
    var statisticsQueryOption: HKStatisticsOptions {
        .cumulativeSum
    }
    
    var hkUnit: HKUnit {
        switch self {
        case .stepCount:
            return .count()
        case .exerciseTime:
            return .minute()
        case .standTime:
            return .minute()
        case .activeEnergyBurned:
            return .largeCalorie()
        case .distanceWalkingRunning:
            return .mile()
        case .distanceCycling:
            return .mile()
        case .distanceSwimming:
            return .mile()
        case .distanceDownhillSnowSports:
            return .mile()
        case .distanceWheelchair:
            return .mile()
        }
    }
}
