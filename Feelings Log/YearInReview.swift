//
//  YearInReview.swift
//  Feelings Log
//
//  Created by Luis García on 27/01/24.
//

import Foundation
import SwiftUI
import CoreData

struct YearGridView: View {
    // TODO: Cada item del grid debe tener un ID como key para obtenerlo del Model
    // TODO: Mes estático, debe considerar ver por año (Desde 2024)
    // TODO: Agregar un higher level state para compartir la data entre la vista 1 y la vista 2
    // TODO: Agregar % de emotion
    // TODO: Exportar como Imagen para share! 🥳
    let year: Int
    
    @State private var dateFeelingMap: [String: Int] = [:]
    
    
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
    
    func formatDate(dayOfYear: Int) -> String {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.day = dayOfYear

        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            return dateFormatter.string(from: date)
        }

        return ""
    }
    
    var body: some View {
        ScrollView {
            Text("Year \(year) in review")
                .font(.title)
                .padding(.horizontal)
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(daysInYear, id: \.self) { day in
                    let key = formatDate(dayOfYear: day)
                    Text("")
                        .frame(width: 15, height: 15)
                        .cornerRadius(4)
                        .background(backgroundByMatchDate(dateFeelingMap[key] ?? 0))
                        .foregroundColor(forecolorByMatchDate(dateFeelingMap[key] ?? 0))
                    
                }
            }
            .padding()
        }
        .navigationTitle("Año \(year)")
        .onAppear {
            // Update state with the data from the store.
            initFetch()
        }
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
    
    private func initFetch() {
        let feelingRecords = fetchFeelings()
        
        // Reinicia el diccionario para asegurarte de que empieza limpio cada vez que actualizas los datos
        dateFeelingMap = [:]
        
        for record in feelingRecords {
            guard let dateStr = record.date_string, let feeling = record.feeling else { continue }
            
            // Asigna el feeling a la fecha correspondiente
            // Si hay múltiples registros para la misma fecha, este código sobrescribirá los valores anteriores con los más recientes
            dateFeelingMap[dateStr] = Int(feeling)
        }
        
        print(dateFeelingMap)
    }
    
    private func fetchFeelings() -> [FeelingEntity] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FeelingEntity")
        
        do {
            if let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [FeelingEntity] {
                // Devuelve los resultados obtenidos
                return fetchedResults
            }
        } catch let error as NSError {
            // Manejar el error
            print("No se pudo recuperar los datos. \(error), \(error.userInfo)")
        }
        
        // Devuelve un arreglo vacío si la recuperación falla
        return []
    }
    
    private func updateDateFeelingMap() {
        let feelingRecords = fetchFeelings()
        
        // Reinicia el diccionario para asegurarte de que empieza limpio cada vez que actualizas los datos
        dateFeelingMap = [:]
        
        for record in feelingRecords {
            guard let dateStr = record.date_string, let feeling = record.feeling else { continue }
            
            // Asigna el feeling a la fecha correspondiente
            // Si hay múltiples registros para la misma fecha, este código sobrescribirá los valores anteriores con los más recientes
            dateFeelingMap[dateStr] = Int(feeling)
        }
    }
    
    private func forecolorByMatchDate(_ value: Int) -> Color {
        switch value {
        case 1:
            return Color.green
        case 2:
            return Color.orange
        case 3:
            return Color.red
        default:
            return Color.black
        }
    }
    
    
}
