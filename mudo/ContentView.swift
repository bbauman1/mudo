//
//  ContentView.swift
//  mudo
//
//  Created by Brett Bauman on 12/20/21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("appColor") var appColor: AppColor = .default
    
    let moodStore = MoodStore()
    
    var body: some View {
        TabView {
            TodayView(viewModel: TodayViewModel(moodStore: moodStore))
                .tabItem {
                    Label("Today", systemImage: "circle.hexagonpath")
                }
            
            HistoryView(viewModel: HistoryViewModel(moodStore: moodStore))
                .tabItem {
                    Label("History", systemImage: "line.3.horizontal")
                }
        }
        .accentColor(appColor.color)
        .tint(appColor.color)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
