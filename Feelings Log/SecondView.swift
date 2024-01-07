//
//  SecondView.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//

import Foundation
import SwiftUI

struct SecondView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: ThirdView()) {
                Text("Ir a Tercera Vista")
            }
        }
        .navigationBarTitle("Segunda Vista")
    }
}

