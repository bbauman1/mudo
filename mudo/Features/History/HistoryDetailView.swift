//
//  HistoryDetailView.swift
//  mudo
//
//  Created by Brett Bauman on 12/22/21.
//

import SwiftUI

struct HistoryDetailView: View {
    
    @ObservedObject var viewModel: HistoryDetailViewModel
    
    var entry: HistoryEntry { viewModel.entry }
    
    var body: some View {
        ScrollView {
            Group {
                if !entry.note.isEmpty {
                    note
                }
                
                if !viewModel.workoutEntries.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Workouts")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                        VStack(spacing: 8) {
                            ForEach(viewModel.workoutEntries) {
                                WorkoutCardView(entry: $0)
                            }
                        }
                    }
                }
                
                if !viewModel.healthEntries.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        if !viewModel.workoutEntries.isEmpty {
                            Text("Overall stats")
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                        }
                        VStack(spacing: 8) {
                            ForEach(viewModel.healthEntries) {
                                HealthCardView(dataType: $0.dataType, value: $0.value)
                            }
                        }
                    }
                }
                
                if viewModel.shouldShowEmptyState {
                    healthPermissionsEmptyStateView
                }
                
                if viewModel.shouldShowPermissionsPrompt {
                    healthPermissionsPromptView
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
        .navigationTitle(entry.mood.emojiWithName)
    }
    
    var note: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "note.text")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Text("Note • " + entry.dateStringAbbreviated)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
            }
            HStack {
                Text(entry.note)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding()
        .multilineTextAlignment(.leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.accentColor)
        )
    }
    
    var healthPermissionsEmptyStateView: some View {
        VStack(alignment: .leading) {
            Text("No Apple Health data found for this day. Double check that your Apple Health permissions are enabled in the Health app. Health > Sharing tab > Apps > mudo")
                .font(.system(.callout, design: .rounded))
            HStack {
                Spacer()
                Button("Open Health") {
                    if let url = URL(string: "x-apple-health://sources") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
    
    var healthPermissionsPromptView: some View {
        VStack(alignment: .leading) {
            Text("Allow Health permissions to see your daily health data alongside your mood")
                .font(.system(.callout, design: .rounded))
            HStack {
                Spacer()
                Button("Show Health data") {
                    viewModel.requestInitialPermissions()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
