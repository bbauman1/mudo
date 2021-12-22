//
//  HistoryRowView.swift
//  mudo
//
//  Created by Brett Bauman on 12/22/21.
//

import SwiftUI

struct HistoryRowView: View {
    
    let entry: HistoryViewModel.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.mood.emojiWithName)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
            Text(entry.dateString)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(Color(.secondaryLabel))
        }
    }
}
