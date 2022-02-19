//
//  HealthEntry.swift
//  mudo
//
//  Created by Brett Bauman on 2/18/22.
//

import Foundation

struct HealthEntry: Identifiable {
    let id = UUID()
    let dataType: HealthDataType
    let value: Double
}
