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
            FirstView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Primero")
                }
                .tag(1)

            SecondView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Segundo")
                }
                .tag(2)

            ThirdView()
                .tabItem {
                    Image(systemName: "bolt.fill")
                    Text("Tercero")
                }
                .tag(3)
        }
    }
}

