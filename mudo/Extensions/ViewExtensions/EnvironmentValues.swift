//
//  EnvironmentValues.swift
//  mudo
//
//  Created by Brett Bauman on 2/19/22.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var appThemeColor: Color {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

private struct AppThemeKey: EnvironmentKey {
    static let defaultValue = AppColor.default.color
}
