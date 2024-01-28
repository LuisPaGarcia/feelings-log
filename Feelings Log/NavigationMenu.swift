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
    // Añade más pestañas según sea necesario
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
            
            YearInReview()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Year in Review")
                }
                .tag(Tab.segunda)
        }
        .animation(.easeInOut, value: selectedTab) // Aplica la animación al cambiar de pestaña

    }
}

