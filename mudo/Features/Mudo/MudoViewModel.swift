//
//  MudoViewModel.swift
//  mudo
//
//  Created by Brett Bauman on 1/24/22.
//

import Foundation
import SwiftUI

class MudoViewModel: ObservableObject {
    
    @ObservedObject var deeplinkRouter: DeeplinkRouter
    
    @Published var state: State = .empty
    @Published var recordButtonText: String = ""
    @Published var isMoodEditorPresented = false
    
    private let moodStore: MoodStore
    private let healthStore: HealthStore
    
    private var subscriptions = Subscriptions()
    
    init(moodStore: MoodStore, healthStore: HealthStore, deeplinkRouter: DeeplinkRouter) {
        self.moodStore = moodStore
        self.healthStore = healthStore
        self.deeplinkRouter = deeplinkRouter
        
        moodStore.history
            .map { $0.isEmpty ? State.empty : .populated }
            .assign(to: &$state)
        
        moodStore.isTodayRecorded
            .map { $0 ? "Edit todays mood" : "Record todays mood" }
            .assign(to: &$recordButtonText)
    }
    
    func makeMoodEditorViewModel() -> MoodEditorViewModel {
        MoodEditorViewModel(moodStore: moodStore)
    }
    
    func makeHistoryViewModel() -> HistoryViewModel {
        HistoryViewModel(moodStore: moodStore, healthStore: healthStore)
    }
    
    func onAppear() {
        deeplinkRouter.$isMoodEditorPresented
            .receive(on: DispatchQueue.main)
            .assign(to: &$isMoodEditorPresented)
    }
}

extension MudoViewModel {
    enum State {
        case empty
        case populated
    }
}
