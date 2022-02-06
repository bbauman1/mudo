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
        ForEach(viewModel.history) { entry in
            if !entry.note.isEmpty {
                NavigationLink {
                    HistoryDetailView(entry: entry)
                } label: {
                    HistoryRowView(entry: entry)
                }
            } else {
                HistoryRowView(entry: entry)
            }
        }
    }
}
