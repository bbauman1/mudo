//
//  TodayViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import Combine
import Foundation
import UIKit

class TodayViewModel: ObservableObject {
    
    @Published var note: String = ""
    @Published private(set) var mood: Mood?
    
    private let moodStore: MoodStore
    private let feedbackGenerator = UIImpactFeedbackGenerator()
    
    private var subscriptions = Subscriptions()
    
    var scrollToTop: AnyPublisher<Void, Never> {
        Publishers.Merge(_scrollToTop, keyboardWillAppear)
            .eraseToAnyPublisher()
    }
    
    var keyboardWillAppear: AnyPublisher<Void, Never> {
        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    private let _scrollToTop = PassthroughSubject<Void, Never>()
    
    init(moodStore: MoodStore) {
        self.moodStore = moodStore
        
        didAppear()
    }
    
    func recordMood() {
        guard let mood = mood else { return }
        feedbackGenerator.impactOccurred(intensity: 0.75)
        moodStore.store(mood, note: note)
        DispatchQueue.main.async {
            self.mood = nil
            self.note = ""
        }
    }
    
    func selectMood(_ mood: Mood) {
        feedbackGenerator.impactOccurred(intensity: 0.75)
        self.mood = mood
        _scrollToTop.send()
    }
    
    func undoTodaysEntry() {
        feedbackGenerator.impactOccurred(intensity: 0.33)
        moodStore.undoTodaysEntry()
    }
    
    func impactOccurred() {
        feedbackGenerator.impactOccurred(intensity: 0.75)
    }
    
    func didAppear() {
        moodStore.todaysEntry
            .receive(on: DispatchQueue.main)
            .sink { [weak self] entry in
                self?.mood = entry?.mood
                self?.note = entry?.note ?? ""
            }
            .store(in: &subscriptions)
    }
}
