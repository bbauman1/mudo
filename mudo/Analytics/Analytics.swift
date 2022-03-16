//
//  Analytics.swift
//  mudo
//
//  Created by Brett Bauman on 3/15/22.
//

import Foundation
import Mixpanel

struct Analytics {
    
    static func initialize() {
        Mixpanel.initialize(token: "da5988306b498028ef993521073bd296")
    }
    
    static func track(_ event: AnalyticsEvent) {
        Mixpanel.mainInstance().track(event: event.event, properties: event.properties)
    }
}

enum AnalyticsEvent {
    
    case recordedMood(Mood)
    case setAppColor(AppColor)
}

extension AnalyticsEvent {
    
    var event: String {
        switch self {
        case .recordedMood:
            return "recordedMood"
        case .setAppColor:
            return "setAppColor"
        }
    }
    
    var properties: Properties {
        switch self {
        case .recordedMood(let mood):
            return [
                "emoji": mood.emoji,
                "name": mood.displayName
            ]
        case .setAppColor(let appColor):
            return [
                "color": appColor.rawValue
            ]
        }
    }
}
