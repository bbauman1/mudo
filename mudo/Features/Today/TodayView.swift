//
//  TodayView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct TodayView: View {

    @ObservedObject var viewModel: TodayViewModel
    @State var isSettingsPresented: Bool = false
    
    var body: some View {
        NavigationView {
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isSettingsPresented = true
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
                .sheet(isPresented: $isSettingsPresented) {
                    SettingsView()
                }
        }
    }
    
    @ViewBuilder var content: some View {
        if viewModel.shouldShowRecordView {
            recordView
        } else {
            recordingCompleteView
        }
    }
    
    var recordView: some View {
        VStack {
            Spacer()
            Text("How are you feeling today?")
                .font(.system(size: 24, weight: .semibold, design: .rounded))
            Spacer()
            moodButtons
            Spacer()
            submitButton
            Spacer()
        }
    }
    
    var moodButtons: some View {
        VStack(spacing: 24) {
            ForEach(Mood.allCases, id: \.displayName) { mood in
                Button(mood.displayName) {
                    viewModel.selectMood(mood)
                }
                .padding()
                .overlay(
                    viewModel.mood == mood
                    ? RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.accentColor, lineWidth: 3)
                    : nil
                )
            }
        }
    }
    
    var submitButton: some View {
        Button("Save mood") {
            withAnimation {
                viewModel.recordMood()
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(viewModel.mood == nil)
    }
    
    var recordingCompleteView: some View {
        GroupBox {
            VStack {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.accentColor)
                    .frame(width: 125, height: 125)
                Button("Undo today's mood") {
                    withAnimation {
                        viewModel.undoTodaysEntry()
                    }
                }
            }
        }
    }
}
