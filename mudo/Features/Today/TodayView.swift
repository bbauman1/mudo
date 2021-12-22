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
    @State var isNoteExpanded: Bool = false
    @FocusState private var isNoteFocused: Bool
    
    private let scrollAnchorId = 333
    
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
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 24) {
                        Text("How are you feeling today?")
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                        moodButtons
                        noteView
                        submitButton
                        scrollAnchor
                    }
                    .padding([.horizontal], 24)
                    .onReceive(viewModel.scrollToTop) { _ in
                        withAnimation {
                            proxy.scrollTo(scrollAnchorId)
                        }
                    }
                }
            }
    }
    
    var moodButtons: some View {
        VStack {
            ForEach(Array(Mood.displayOrder.enumerated()), id: \.0) { index, moodRow in
                HStack {
                    Spacer()
                    ForEach(moodRow, id: \.displayName) { mood in
                        Button {
                            viewModel.selectMood(mood)
                        } label: {
                            GroupBox {
                                VStack {
                                    Text(mood.emoji)
                                        .font(.system(size: 32))
                                    Text(mood.displayName)
                                }
                            }
                            .groupBoxStyle(.circular)
                        }                        
                        .overlay(viewModel.mood == mood ? Circle().stroke(Color.accentColor, lineWidth: 3) : nil)
                        Spacer()
                    }
                }
            }
        }
    }
    
    var noteView: some View {
        VStack(spacing: 0) {
            Button {
                withAnimation {
                    isNoteExpanded.toggle()
                    isNoteFocused = isNoteExpanded
                    viewModel.impactOccurred()
                }
            } label: {
                HStack {
                    Text("Add a note")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                    Spacer()
                    Image(systemName: isNoteExpanded ? "minus.circle.fill" : "plus.circle.fill")
                }
                .padding()
            }
            
            if isNoteExpanded {
                Divider()
                    .padding(.horizontal)
                TextField("Optional, but recommended", text: $viewModel.note)
                    .focused($isNoteFocused)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isNoteFocused = true
                        }
                    }
            }
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    
    var submitButton: some View {
        Button("Save mood") {
            withAnimation {
                viewModel.recordMood()
            }
        }
        .buttonStyle(.capsule)
        .disabled(viewModel.mood == nil)
    }
    
    var scrollAnchor: some View {
        Color.clear
            .frame(height: 12)
            .id(scrollAnchorId)
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
