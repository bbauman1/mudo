//
//  TodayView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct TodayView: View {

    @AppStorage("appColor") var appColor: AppColor = .default
    @ObservedObject var viewModel: TodayViewModel
    @Binding var isPresented: Bool
    @State var isNoteExpanded: Bool = false
    @FocusState private var isNoteFocused: Bool
    
    private let scrollAnchorId = 333
    
    var body: some View {
        recordView
            .onAppear(perform: viewModel.didAppear)
    }
    
    var recordView: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(spacing: 24) {
                    titleText
                    wrappingMoodButtons
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
                    Image(systemName: noteImageName)
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
                    .submitLabel(.done)
                    .onSubmit {
                        viewModel.recordMood()
                        isPresented = false
                    }
            }
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    
    var noteImageName: String {
        if isNoteExpanded {
            return "minus.circle.fill"
        } else {
            if viewModel.note.isEmpty {
                return "plus.circle.fill"
            } else {
                return "checkmark.circle.fill"
            }
        }
    }
    
    var submitButton: some View {
        Button {
            withAnimation {
                viewModel.recordMood()
                isPresented = false
            }
        } label: {
            Text("Save mood")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .frame(maxWidth: .infinity)
        .disabled(viewModel.mood == nil)
    }
    
    var scrollAnchor: some View {
        Color.clear
            .frame(height: 6)
            .id(scrollAnchorId)
    }
    
    // MARK: WrappingMoodButtons
    // todo: move to separate file

    @State private var totalHeight = CGFloat.zero
    let moods = Mood.allCases

    var wrappingMoodButtons: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(Mood.allCases, id: \.self) { mood in
                self.item(for: mood)
                    .padding([.horizontal, .vertical], 8)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if mood == moods.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if mood == moods.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for mood: Mood) -> some View {
        Button {
            viewModel.selectMood(mood)
        } label: {
            Label {
                Text(mood.displayName)
            } icon: {
                Text(mood.emoji)
                    .font(.system(size: 28))
            }
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .tint(appColor.color)
        .overlay(viewModel.mood == mood
                 ? Capsule().stroke(appColor.color, lineWidth: 2)
                 : nil)
        .scaleEffect(viewModel.mood == mood ? 1.1 : 1)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
