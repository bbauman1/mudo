//
//  CapsuleButtonSyle.swift
//  mudo
//
//  Created by Brett Bauman on 12/21/21.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

extension ButtonStyle where Self == CapsuleButtonStyle {
    static var capsule: Self { .init() }
}
