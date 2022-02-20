//
//  WorkoutEntry.swift
//  mudo
//
//  Created by Brett Bauman on 2/20/22.
//

import Foundation

struct WorkoutEntry: Identifiable {
    let id = UUID()
    let workoutName: String
    let durationValue: Double
    let durationMeasurement: Measurement
    let energyValue: Double
    let energyMeasurement: Measurement
}
