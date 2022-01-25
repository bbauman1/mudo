//
//  HistoryView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel: HistoryViewModel
    
    @State var showRecordSheet = false
    
    var list: some View {
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
    
    var body: some View {
        list
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
            List {
                Section {
                    Button {
                        showRecordSheet = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text("How ya feeling?")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(.black)
                            Text("Record today's mood")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                    }
                } header: {
                    Text("Today")
                }
                .headerProminence(.increased)

                Section {
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
                } header: {
                    Text("History")
                }
                .headerProminence(.increased)
            }
            .navigationTitle("History")
        }
        
    }
}
