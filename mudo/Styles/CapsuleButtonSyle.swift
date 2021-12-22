//
//  CapsuleButtonSyle.swift
//  mudo
//
//  Created by Brett Bauman on 12/21/21.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(isEnabled ? Color.accentColor : Color(.systemFill))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

extension ButtonStyle where Self == CapsuleButtonStyle {
    static var capsule: Self { .init() }
}
