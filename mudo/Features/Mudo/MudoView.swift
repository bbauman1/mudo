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
                        if viewModel.state == .populated {
                            Button {
                                isSettingsPresented = true
                            } label: {
                                Image(systemName: "gearshape")
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
                .navigationTitle(viewModel.state == .empty ? "" : "Mudo")                
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
        MudoEmptyView {
            isMoodEditorPresented = true
        }
    }
    
    var listView: some View {
        List {
            HistoryView(viewModel: viewModel.makeHistoryViewModel())
        }
        .safeAreaInset(edge: .bottom, content: {
            Button {
                isMoodEditorPresented = true
            } label: {
                Text(viewModel.recordButtonText)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .padding(.horizontal)
            .padding(.horizontal)
        })
        .listStyle(.insetGrouped)
    }
}
