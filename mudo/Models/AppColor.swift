//
//  AppColor.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Foundation
import SwiftUI

enum AppColor: String, CaseIterable, Codable {
    
    case wildBlueYonder
    case cyan
    case tuscany
    case redSalsa
    case red
    case teal
    case blue
    case green
    case pink
    case mint
    case orange
    case yellow
    case indigo
    case purple
    case brown
    case gray
    
    static let `default`: AppColor = .teal
    
    var color: Color {
        switch self {
        case .wildBlueYonder:
            return .init(hex: 0xA7BBEC)
        case .redSalsa:
            return .init(hex: 0xEF5B5B)
        case .tuscany:
            return .init(hex: 0xB79492)
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
