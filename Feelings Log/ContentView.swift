//
//  ContentView.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Primero")
                }

            SecondView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Segundo")
                }

            ThirdView()
                .tabItem {
                    Image(systemName: "bolt.fill")
                    Text("Tercero")
                }
        }
    }
}

