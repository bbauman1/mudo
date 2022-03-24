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
        if let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date) {
            let endOfDay = Calendar.current.startOfDay(for: nextDay)
            return predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        } else {
            return predicateForSamples(withStart: startOfDay, end: date, options: .strictStartDate)
        }
    }
}
