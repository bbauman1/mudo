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
            NavigationLink {
                HistoryDetailView(viewModel: viewModel.makeDetailViewModel(for: entry))
            } label: {
                HistoryRowView(entry: entry)
            }
        }
    }
}
