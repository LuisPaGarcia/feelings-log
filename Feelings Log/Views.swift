//
//  Views.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//

import Foundation
import SwiftUI

struct EmotionLogger: View {
    @Binding var selectedTab: Int
    var body: some View {
        CalendarView(selectedTab: $selectedTab)
    }
}

struct YearInReview: View {
    // TODO: Considera que tiene 14 columnas en lugar de 7. Podrían ser por mes?
    // TODO: Mes estático, debe considerar ver por año (Desde 2024)
    // TODO: Agregar un higher level state para compartir la data entre la vista 1 y la vista 2
    // TODO: Agregar % de emotion
    // TODO: Exportar como Imagen para share! 🥳
    
    // Define las columnas para el grid
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 14)
    
    var body: some View {
        // Scroll view para poder desplazarse a través del grid
        VStack {
            Text("Current year in Review")
                .font(.headline)
                .padding()
            // Crea un LazyVGrid con 14 columnas
            LazyVGrid(columns: columns) {
                // ForEach para generar 52 * 7 = 364 celdas
                ForEach(0..<364, id: \.self) { index in
                    // Contenido de cada celda
                    Text("")
                        .frame(width: 10, height: 10) // Tamaño de la celda
                        .background(Color.gray.opacity(0.3)) // Color de fondo de la celda
                }
            }
            .padding() // Agrega un poco de espacio alrededor del grid
        }
    }
}


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
