//
//  Calendar.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//

import Foundation
import SwiftUI

var evaluaciones: [Date: String] = [:]
var day_box_dimension: CGFloat = 40

struct CalendarData {
    private var calendar = Calendar.current
    private(set) var currentDate = Date()
    
    // Obtiene el nombre del mes y año para el título
    func monthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: currentDate)
    }
    
    // Obtiene el día del mes seleccionado
    func daySelectedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: currentDate)
    }
    
    // Obtiene el mes del día seleccionado
    func monthSelectedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: currentDate)
    }
    
    // Obtiene el mes del día seleccionado
    func yearSelectedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter.string(from: currentDate)
    }
    
    // Obtiene el mes del día seleccionado
    func selectedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM DD, YYYY"
        return formatter.string(from: currentDate)
    }
    
    func createDate(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return calendar.date(from: dateComponents)
    }
    
    
    // Calcula los días del mes actual
    func daysInMonth() -> [String] {
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else { return [] }
        return range.map { String($0) }
    }
    
    // Encuentra el primer día del mes actual
    private func firstDayOfMonth() -> Date {
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        return calendar.date(from: components)!
    }
    
    // Obtiene el día de la semana para el primer día del mes
    func firstWeekdayOfMonth() -> String {
        let firstDay = firstDayOfMonth()
        let weekDay = calendar.component(.weekday, from: firstDay)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Nombre completo del día de la semana
        return formatter.weekdaySymbols[weekDay - 1]
    }
    
    // Convierte el nombre del día de la semana en inglés en un número entero
    func weekdayNumber() -> Int {
        let weekdayString = firstWeekdayOfMonth()
        let weekdays = ["Sunday": 0, "Monday": 1, "Tuesday": 2, "Wednesday": 3, "Thursday": 4, "Friday": 5, "Saturday": 6]
        
        return weekdays[weekdayString] ?? -1 // Retorna -1 si no se encuentra el día
    }
    
    func createArrayBasedOnWeekday() -> [String] {
        let size = weekdayNumber()
        guard size >= 0 else {
            return [] // Retorna un array vacío si el tamaño es -1 (día no encontrado)
        }
        return Array(repeating: "0", count: size)
    }
    
    func numberOfWeeksInMonth() -> Int {
        let firstDayOfMonth = firstDayOfMonth()
        let rangeOfDays = calendar.range(of: .day, in: .month, for: currentDate)!
        let lastDayOfMonth = calendar.date(byAdding: .day, value: rangeOfDays.count - 1, to: firstDayOfMonth)!
        
        let firstWeek = calendar.component(.weekOfMonth, from: firstDayOfMonth)
        let lastWeek = calendar.component(.weekOfMonth, from: lastDayOfMonth)
        
        return lastWeek - firstWeek + 1
    }
    
    func getDateKey(day: String) -> String {
        // Acciones al seleccionar un día
        //print(calendarData.monthSelectedString())
        let month = Int(self.monthSelectedString()) ?? 1
        //print(calendarData.yearSelectedString())
        let year = Int(self.yearSelectedString()) ?? 1991
        //print(day)
        let selectedDate = self.createDate(year: year, month: month, day: Int(day) ?? 1)
        //print(selectedDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: selectedDate ?? Date())
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
    @Binding var selectedTab: Int
    
    @State private var calendarData = CalendarData()
    @State private var tapped = Array(repeating: false, count: 32)
    @State private var isModalPresented = false
    
    // State to handle flow with the modal
    @State private var selectedDate = ""
    @State private var selectedDateKey = ""
    @State private var feelingSelected = 0
    @State private var dateFeelingMap: [String: Int] = [:]
    
    fileprivate func handleTapOnDay(day: Int) {
        // Acciones al seleccionar un día
        //print(calendarData.monthSelectedString())
        let month = Int(calendarData.monthSelectedString()) ?? 1
        //print(calendarData.yearSelectedString())
        let year = Int(calendarData.yearSelectedString()) ?? 1991
        //print(day)
        let selectedDate = calendarData.createDate(year: year, month: month, day: Int(day))
        //print(selectedDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        self.selectedDate = formatter.string(from: selectedDate ?? Date())
        formatter.dateFormat = "yyyyMMdd"
        self.selectedDateKey = formatter.string(from: selectedDate ?? Date())
        self.isModalPresented.toggle()
    }
    
    var body: some View {
        VStack {
            Text(calendarData.monthString())
                .font(.title)
                .padding(.horizontal)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                // Padding on top
                ForEach(calendarData.createArrayBasedOnWeekday(), id: \.self) { day in
                    Text("")
                        .frame(width: day_box_dimension, height: day_box_dimension)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(5)
                }
                
                // Calendar content
                ForEach(calendarData.daysInMonth(), id: \.self) { day in
                    Text(day)
                        .frame(width: day_box_dimension, height: day_box_dimension)
                        .background(backgroundByMatchDate(dateFeelingMap[calendarData.getDateKey(day: day)] ?? 0))
                        .foregroundColor(forecolorByMatchDate(dateFeelingMap[calendarData.getDateKey(day: day)] ?? 0))
                        .overlay(addOverlayIfToday(isToday: true))
                        .cornerRadius(5)
                        .onTapGesture {
                            handleTapOnDay(day: Int(day) ?? 1)
                        }
                }
                
                // Padding bottom
                if calendarData.numberOfWeeksInMonth() < 6 {
                    ForEach(Array(repeating: "", count: 7), id: \.self) { day in
                        Text("")
                            .frame(width: day_box_dimension, height: day_box_dimension)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(5)
                    }
                }
            }
            .padding(.horizontal)
            
            VStack {
                Text("Today Log")
                    .frame(maxWidth: .infinity, minHeight: 75)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(5)
                    .onTapGesture {
                        let today = Date()
                        let calendar = Calendar.current
                        let day = calendar.component(.day, from: today)
                        handleTapOnDay(day: day)
                    }
            }
            .padding(.horizontal)
            
            HStack {
                Button("Past Month") {
                    calendarData.prevMonth()
                }
                
                Spacer()
                
                Button("Next Month") {
                    calendarData.nextMonth()
                }
            }
            .padding()
        }
        .sheet(isPresented: $isModalPresented) {
            ModalView(
                selectedDate: $selectedDate,
                selectedDateKey: $selectedDateKey,
                feelingSelected: $feelingSelected,
                onSelectFeeling: onSelectFeeling
            )
        }
    }
    
    func onSelectFeeling(selectedDateKey: String, feelingSelected: Int) -> Void {
        dateFeelingMap[selectedDateKey] = feelingSelected
        print("selected date: \(selectedDateKey), feeling: \(feelingSelected)")
        print("Mapa actualizado: \(dateFeelingMap)")
    }
    
    private func backgroundByMatchDate(_ value: Int) -> Color {
        switch value {
        case 1:
            return Color.green.opacity(0.3) // happy happy happy
        case 2:
            return Color.yellow.opacity(0.3) // mid mid mid
        case 3:
            return Color.red.opacity(0.3) // sad sad sad sad
        default:
            return Color.gray.opacity(0.3) // No emotion logged
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

    
    private func addOverlayIfToday(isToday: Bool) -> Color {
        if isToday == true {
            return Color.gray.opacity(0.0)
        }
        
        return Color.black.opacity(0)
    }
}
