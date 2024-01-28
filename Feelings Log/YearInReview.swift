//
//  YearInReview.swift
//  Feelings Log
//
//  Created by Luis García on 27/01/24.
//

import Foundation
import SwiftUI

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
