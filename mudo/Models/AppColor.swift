//
//  AppColor.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation
import SwiftUI

enum AppColor: String, CaseIterable, Codable {
    case red
    case green
    case blue
    case pink
    case orange
    case yellow
    case mint
    case teal
    case cyan
    case indigo
    case purple
    case brown
    case gray
    
    static let `default`: AppColor = .blue
    
    var color: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .pink:
            return .pink
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .mint:
            return .mint
        case .teal:
            return .teal
        case .cyan:
            return .cyan
        case .indigo:
            return .indigo
        case .purple:
            return .purple
        case .brown:
            return .brown
        case .gray:
            return .gray
        }
    }
}
