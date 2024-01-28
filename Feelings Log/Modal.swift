//
//  Modal.swift
//  Feelings Log
//
//  Created by Luis García on 27/01/24.
//

import Foundation
import SwiftUI

struct ModalView: View {
    @Binding var selectedDate: String
    @Binding var selectedDateKey: String
    @Binding var feelingSelected: Int
    var onSelectFeeling: (String, Int) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    // TODO: Mejorar el UI del modal (Parece un puto semáforo)
    // TODO: Mejorar posición del calendario (Maybe swipe? Subirlos?)
    // TODO: Agregar storage persistente y high level.
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
                    .fill(Color.green.opacity(0.8)) // Color del fondo
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
                    .fill(Color.yellow.opacity(0.8)) // Color del fondo
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
                    .fill(Color.red.opacity(0.8)) // Color del fondo
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