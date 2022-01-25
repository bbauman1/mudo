//
//  TodayView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct TodayView: View {

    @ObservedObject var viewModel: TodayViewModel
    @Binding var isPresented: Bool
    @State var isNoteExpanded: Bool = false
    @FocusState private var isNoteFocused: Bool
    
    private let scrollAnchorId = 333
    
    private let buttonRows = [
        GridItem(.flexible(minimum: 80)),
        GridItem(.flexible(minimum: 80))
    ]
    
    var body: some View {
        recordView
            .onAppear(perform: viewModel.didAppear)
    }
    
    var recordView: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(spacing: 24) {
                    titleText
                    gridButtons
                    noteView
                    submitButton
                    scrollAnchor
                }
                .padding([.horizontal, .top], 24)
                .onReceive(viewModel.scrollToTop) { _ in
                    withAnimation {
                        proxy.scrollTo(scrollAnchorId)
                    }
                }
            }
        }
    }
    
    var titleText: some View {
        Text("How are you feeling today?")
            .font(.system(size: 24, weight: .semibold, design: .rounded))
    }
    
    var gridButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: buttonRows) {
                ForEach(Mood.allCases, id: \.displayName) { mood in
                    Button {
                        viewModel.selectMood(mood)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 32, style: .continuous)
                                .fill(Color(.secondarySystemBackground))
                            HStack {
                                Text(mood.emoji)
                                    .font(.system(size: 28))
                                Text(mood.displayName)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                        .overlay(viewModel.mood == mood
                                 ? RoundedRectangle(cornerRadius: 32, style: .continuous)
                                    .stroke(Color.accentColor, lineWidth: 3)
                                 : nil)
                    }
                }
                Spacer()
            }
            .frame(height: 160)
            .padding()
        }
        .padding(.horizontal, -24)
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
                isPresented = false
            }
        }
        .buttonStyle(.capsule)
        .disabled(viewModel.mood == nil)
    }
    
    var scrollAnchor: some View {
        Color.clear
            .frame(height: 1)
            .id(scrollAnchorId)
    }
}
