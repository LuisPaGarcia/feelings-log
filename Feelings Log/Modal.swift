//
//  Modal.swift
//  Feelings Log
//
//  Created by Luis García on 27/01/24.
//

import Foundation
import SwiftUI
import CoreData

struct ModalView: View {
    @Binding var selectedDate: String
    @Binding var selectedDateKey: String
    @Binding var feelingSelected: Int
    var onSelectFeeling: (String, Int, String) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    @State private var comment: String = "" // Estado para almacenar el texto ingresado

    // TODO: Mejorar el UI del modal (Parece un puto semáforo)
    // TODO: Mejorar posición del calendario (Maybe swipe? Subirlos?)
    // TODO: Agregar storage persistente y high level.
    var body: some View {
        VStack {
            Text(selectedDate)
                .font(.headline)
                .padding()
            Text("How are you feeling today?")
                .font(.headline)
                .padding()
            Spacer()
            // Botón 1: "Good 😄"
            Button(action: {
                feelingSelected = 1
                onSelectFeeling(selectedDateKey, feelingSelected, comment)
                // Acción para el botón 1
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Rectangle()
                    .fill(Color.green.opacity(0.8)) // Color del fondo
                    .cornerRadius(15) // Bordes redondeados
                    .overlay(
                        Text("Nice 😄")
                            .foregroundColor(.white) // Color del texto
                            .font(.system(size: 32)) // Tamaño del texto
                    )
            }
            .padding(.horizontal)

            // Botón 2: "Normal 🙂"
            Button(action: {
                feelingSelected = 2
                onSelectFeeling(selectedDateKey, feelingSelected, comment)
                // Acción para el botón 2
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Rectangle()
                    .fill(Color.yellow.opacity(0.8)) // Color del fondo
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
                onSelectFeeling(selectedDateKey, feelingSelected, comment)
                // Acción para el botón 3
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Rectangle()
                    .fill(Color.red.opacity(0.8)) // Color del fondo
                    .cornerRadius(15) // Bordes redondeados
                    .overlay(
                        Text("Not Good 🙁")
                            .foregroundColor(.white) // Color del texto
                            .font(.system(size: 32)) // Tamaño del texto
                    )
            }
            .padding(.horizontal)
            
            
            Spacer() // Puede que necesites ajustar los Spacers según tu layout
            
            // TextEditor con placeholder
            ZStack(alignment: .topLeading) {
                TextEditor(text: $comment)
                    .frame(height: 100) // Ajusta la altura según necesites
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 1))
                    .padding(.horizontal)
                
                if comment.isEmpty {
                    Text("optional comment...")
                        .foregroundColor(.gray) // Color del placeholder
                        .padding(.leading, 25)
                        .padding(.top, 12)
                }
            }
            .cornerRadius(10)
            
            
            Spacer() // Ajusta según sea necesario
            
            Button("Cerrar") {
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }
    }
    
}
