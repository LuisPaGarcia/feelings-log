//
//  ContentView.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 2
    var body: some View {
        TabView(selection: $selectedTab) {
            EmotionLogger(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "heart")
                    Text("Feeling Log")
                }
                .tag(2)
            
            YearInReview()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Year in Review")
                }
                .tag(3)
        }
    }
}

