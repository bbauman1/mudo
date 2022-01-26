//
//  MudoView.swift
//  mudo
//
//  Created by Brett Bauman on 1/24/22.
//

import Combine
import SwiftUI

struct MudoView: View {
    
    @ObservedObject var viewModel: MudoViewModel
    @State var isSettingsPresented: Bool = false
    @State var isTodayEditorPresented: Bool = false
    
    var body: some View {
        NavigationView {
            statefulView
                .sheet(isPresented: $isTodayEditorPresented) {
                    TodayView(viewModel: viewModel.makeTodayViewModel(), isPresented: $isTodayEditorPresented)
                }
                .sheet(isPresented: $isSettingsPresented) {
                    SettingsView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isSettingsPresented = true
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
                .navigationTitle("Mudo")
        }
        
    }
    
    @ViewBuilder var statefulView: some View {
        switch viewModel.state {
        case .empty:
            emptyView
        case .populated:
            listView
        }
    }
    
    var emptyView: some View {
        Button {
            isTodayEditorPresented = true
        } label: {
            VStack {
                Text("No moods recorded yet!")
                Text("Let's fix that")
                Image(systemName: "record.circle")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.accentColor)
                    .frame(width: 125, height: 125)
            }
            .font(.system(size: 24, weight: .semibold, design: .rounded))
            .multilineTextAlignment(.center)
        }
    }
    
    var listView: some View {
        List {
            todaySection
            historySection
        }
        .listStyle(.insetGrouped)
    }
    
    var todaySection: some View {
        Section {
            Button {
                isTodayEditorPresented = true
            } label: {
                Text("Edit todays mood")
            }

        } header: {
            Text("Today")
        }
        .headerProminence(.increased)
    }
    
    var historySection: some View {
        Section {
            HistoryView(viewModel: viewModel.makeHistoryViewModel())
        } header: {
            Text("History")
        }
        .headerProminence(.increased)
    }
}
