//
//  CircularGroupBoxStyle.swift
//  mudo
//
//  Created by Brett Bauman on 12/21/21.
//

import SwiftUI

struct CircularGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(28)
            .background(Color(.systemGroupedBackground))
            .clipShape(Circle())
    }
}

extension GroupBoxStyle where Self == CircularGroupBoxStyle {
    static var circular: Self { .init() }
}
