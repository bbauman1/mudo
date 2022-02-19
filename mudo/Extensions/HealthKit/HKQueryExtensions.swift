//
//  HKQueryExtensions.swift
//  mudo
//
//  Created by Brett Bauman on 2/13/22.
//

import Foundation
import HealthKit

extension HKQuery {
    
    static func predicateForSamples(within date: Date) -> NSPredicate {
        let startOfDay = Calendar.current.startOfDay(for: date)
        return predicateForSamples(withStart: startOfDay, end: date, options: .strictStartDate)
    }
}
