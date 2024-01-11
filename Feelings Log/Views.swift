//
//  Views.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//

import Foundation
import SwiftUI

struct FirstView: View {
    var body: some View {
        Text("Primera Vista")
    }
}

struct SecondView: View {
    @Binding var selectedTab: Int
    var body: some View {
        CalendarView(selectedTab: $selectedTab)
    }
}

struct ThirdView: View {
    var body: some View {
        Text("Tercera Vista")
    }
}
