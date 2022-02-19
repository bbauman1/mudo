//
//  Measurement.swift
//  mudo
//
//  Created by Brett Bauman on 2/18/22.
//

import Foundation

enum Measurement {
    case time(Time)
    case distance
    case calories
    case custom(String)
    
    var unit: String {
        switch self {
        case .time(let time):
            return time.unit
        case .distance:
            return "mi"
        case .calories:
            return "cal"
        case .custom(let string):
            return string
        }
    }
}

extension Measurement {
    enum Time {
        case minutes
        case hours
        
        var unit: String {
            switch self {
            case .minutes:
                return "min"
            case .hours:
                return "hr"
            }
        }
    }
}
