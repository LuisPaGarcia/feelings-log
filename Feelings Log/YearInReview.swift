//
//  YearInReview.swift
//  Feelings Log
//
//  Created by Luis García on 27/01/24.
//

import Foundation
import SwiftUI

struct YearGridView: View {
    // TODO: Mes estático, debe considerar ver por año (Desde 2024)
    // TODO: Agregar un higher level state para compartir la data entre la vista 1 y la vista 2
    // TODO: Agregar % de emotion
    // TODO: Exportar como Imagen para share! 🥳
    let year: Int
    
    var daysInYear: [Int] {
        // Calcula la cantidad de días en el año
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .year, for: date)!
        return Array(range)
    }
    
    // Define la disposición de las celdas en el grid
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 15) // 7 para una semana
    
    var body: some View {
        ScrollView {
            Text("Year \(year) in review")
                .font(.title)
                .padding(.horizontal)
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(daysInYear, id: \.self) { day in
                    Text("")
                        .frame(width: 15, height: 15)
                        .background(backgroundByMatchDate(3))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
            }
            .padding()
        }
        .navigationTitle("Año \(year)")
    }
    
    private func backgroundByMatchDate(_ value: Int) -> Color {
        switch value {
        case 1:
            return Color.green.opacity(0.6) // happy happy happy
        case 2:
            return Color.yellow.opacity(0.6) // mid mid mid
        case 3:
            return Color.red.opacity(0.6) // sad sad sad sad
        default:
            return Color.gray.opacity(0.6) // No emotion logged
        }
    }

}
