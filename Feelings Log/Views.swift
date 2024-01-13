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


struct ModalView: View {
    @Binding var selectedDate: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text(selectedDate)
                .font(.title)
                .padding()
            
            Button("Botón 1") {
                // Acción para el botón 1
            }
            .padding()
            
            Button("Botón 2") {
                // Acción para el botón 2
            }
            .padding()
            
            Button("Botón 3") {
                // Acción para el botón 3
            }
            .padding()
            
            Spacer()
            
            Button("Cerrar") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}
