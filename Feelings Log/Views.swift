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
    @Binding var selectedDateKey: String
    @Binding var feelingSelected: Int
    var onSelectFeeling: (String, Int) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("How are you feeling today?")
                .font(.headline)
                .padding()
            Text(selectedDate)
                .font(.subheadline)
                .padding()
            Spacer()
            // Botón 1: "Good 😄"
            Button(action: {
                feelingSelected = 1
                onSelectFeeling(selectedDateKey, feelingSelected)
                // Acción para el botón 1
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Rectangle()
                    .fill(Color.green) // Color del fondo
                    //.frame(maxWidth: .infinity, minHeight: 75) // Tamaño
                    .cornerRadius(15) // Bordes redondeados
                    .overlay(
                        Text("Good 😄")
                            .foregroundColor(.white) // Color del texto
                            .font(.system(size: 32)) // Tamaño del texto
                    )
            }
            .padding(.horizontal)

            // Botón 2: "Normal 🙂"
            Button(action: {
                feelingSelected = 2
                onSelectFeeling(selectedDateKey, feelingSelected)
                // Acción para el botón 2
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Rectangle()
                    .fill(Color.yellow) // Color del fondo
                    //.frame(maxWidth: .infinity, minHeight: 75) // Tamaño
                    .cornerRadius(15) // Bordes redondeados
                    .overlay(
                        Text("Normal 🙂")
                            .foregroundColor(.white) // Color del texto
                            .font(.system(size: 32)) // Tamaño del texto
                    )
            }
            .padding(.horizontal)

            // Botón 3: "Not Good 🙁"
            Button(action: {
                feelingSelected = 3
                onSelectFeeling(selectedDateKey, feelingSelected)
                // Acción para el botón 3
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Rectangle()
                    .fill(Color.red) // Color del fondo
                    //.frame(maxWidth: .infinity, minHeight: 75) // Tamaño
                    .cornerRadius(15) // Bordes redondeados
                    .overlay(
                        Text("Not Good 🙁")
                            .foregroundColor(.white) // Color del texto
                            .font(.system(size: 32)) // Tamaño del texto
                    )
            }
            .padding(.horizontal)

            Spacer()
            
            Button("Cerrar") {
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }
    }
}
