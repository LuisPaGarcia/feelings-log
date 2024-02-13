//
//  ContentView.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//
import SwiftUI

enum Tab {
    case primera
    case segunda
}

struct ContentView: View {
    //@State private var selectedTab = 1
    @State private var selectedTab: Tab = .primera

    var body: some View {
        TabView(selection: $selectedTab) {
            EmotionLogger()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Feeling Log")
                }
                .tag(Tab.primera)
            
            YearGridView(year: 2024)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Year in Review")
                }
                .tag(Tab.segunda)
        }

    }
}

