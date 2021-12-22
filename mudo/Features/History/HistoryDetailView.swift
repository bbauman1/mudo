//
//  HistoryDetailView.swift
//  mudo
//
//  Created by Brett Bauman on 12/22/21.
//

import SwiftUI

struct HistoryDetailView: View {
    
    let entry: HistoryViewModel.Entry
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "note.text")
                        Text("Note")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                    }
                    HStack {
                        Text(entry.note)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                        Spacer()
                    }
                }
                .padding()
                .multilineTextAlignment(.leading)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle(entry.mood.emojiWithName)
        .navigationBarTitleDisplayMode(.large)
    }
}
