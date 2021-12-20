//
//  TodayView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct TodayView: View {

    @ObservedObject var viewModel: TodayViewModel
    
    var body: some View {
        if viewModel.shouldShowRecordView {
            recordView
        } else {
            recordingCompleteView
        }
    }
    
    var recordView: some View {
        VStack {
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
                    viewModel.mood = mood
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
