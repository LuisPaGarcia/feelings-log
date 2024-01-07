//
//  Calendar.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//

import Foundation
import SwiftUI

struct CalendarData {
    private var calendar = Calendar.current
    private(set) var currentDate = Date()

    // Obtiene el nombre del mes y año para el título
    func monthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: currentDate)
    }

    // Calcula los días del mes actual
    func daysInMonth() -> [String] {
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else { return [] }
        return range.map { String($0) }
    }

    // Navega al mes anterior
    mutating func prevMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = newDate
        }
    }

    // Navega al mes siguiente
    mutating func nextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentDate) {
            currentDate = newDate
        }
    }
}


struct CalendarView: View {
    @State private var calendarData = CalendarData()

    var body: some View {
        VStack {
            Text(calendarData.monthString())
                .font(.title)
                .padding(.horizontal)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                ForEach(calendarData.daysInMonth(), id: \.self) { day in
                    Text(day)
                        .frame(width: 40, height: 40)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(5)
                        .onTapGesture {
                            // Acciones al seleccionar un día
                            print("Día seleccionado: \(day) \(calendarData.monthString())")
                        
                        }
                }
            }
            .padding(.horizontal)

            HStack {
                Button("Mes Anterior") {
                    calendarData.prevMonth()
                }

                Spacer()

                Button("Mes Siguiente") {
                    calendarData.nextMonth()
                }
            }
            .padding()
        }
    }
}
