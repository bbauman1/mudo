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
    @State var isMoodEditorPresented: Bool = false
    @Environment(\.appThemeColor) var appColor
    
    var body: some View {
        NavigationView {
            statefulView
                .sheet(isPresented: $isMoodEditorPresented) {
                    MoodEditorView(viewModel: viewModel.makeMoodEditorViewModel())
                }
                .sheet(isPresented: $isSettingsPresented) {
                    SettingsView()
                        .accentColor(appColor)
                        .tint(appColor)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isSettingsPresented = true
                        } label: {
                            Image(systemName: "gearshape")
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
            isMoodEditorPresented = true
        } label: {
            Text("record your first mood")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
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
                isMoodEditorPresented = true
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
