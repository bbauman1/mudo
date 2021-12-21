//
//  HistoryView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel: HistoryViewModel
    
    var body: some View {
        if viewModel.history.isEmpty {
            emptyView
        } else {
            populatedView
        }        
    }
    
    var emptyView: some View {
        VStack {
            Text("No moods recorded yet.")
            Text("How ya feelin?")
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.accentColor)
                .frame(width: 125, height: 125)
        }
        .font(.system(size: 24, weight: .semibold, design: .rounded))
        .multilineTextAlignment(.center)
    }
    
    var populatedView: some View {
        NavigationView {
            List(viewModel.history) { entry in
                if !entry.note.isEmpty {
                    NavigationLink {
                        Text(entry.note)
                    } label: {
                        HistoryRow(entry: entry)
                    }
                } else {
                    HistoryRow(entry: entry)
                }
            }
            .navigationTitle("History")
        }
    }
}

struct HistoryRow: View {
    
    let entry: HistoryViewModel.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.mood.emoji + entry.mood.displayName)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
            Text(entry.dateString)
                .font(.system(size: 16, weight: .regular, design: .rounded))
        }
    }
}
