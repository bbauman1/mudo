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
    @Environment(\.appThemeColor) var appColor
    
    var body: some View {
        NavigationView {
            statefulView
                .sheet(isPresented: $viewModel.isMoodEditorPresented) {
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
        .navigationViewStyle(.stack)
        .onAppear(perform: viewModel.onAppear)
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
            UIImpactFeedbackGenerator().impactOccurred(intensity: 0.75)
            viewModel.isMoodEditorPresented = true
        }
    }
    
    var listView: some View {
        List {
            HistoryView(viewModel: viewModel.makeHistoryViewModel())
        }
        .safeAreaInset(edge: .bottom, content: {
            Button {
                UIImpactFeedbackGenerator().impactOccurred(intensity: 0.75)
                viewModel.isMoodEditorPresented = true
            } label: {
                Text(viewModel.recordButtonText)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.bottom)
        })
        .listStyle(.insetGrouped)
    }
}
