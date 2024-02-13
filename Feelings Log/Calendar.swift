//
//  Calendar.swift
//  Feelings Log
//
//  Created by Luis García on 7/01/24.
//

import Foundation
import SwiftUI
import CoreData


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
        let month = Int(self.monthSelectedString()) ?? 1
        let year = Int(self.yearSelectedString()) ?? 1991
        let selectedDate = self.createDate(year: year, month: month, day: Int(day) ?? 1)
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
    
    // Navega al mes actual (basado en la fecha actual
    mutating func goToCurrentMonth() {
        let now = Date() // Obtiene la fecha actual
        let yearMonthComponents: Set<Calendar.Component> = [.year, .month] // Define los componentes que nos interesan (año y mes)
        let components = calendar.dateComponents(yearMonthComponents, from: now) // Extrae los componentes de la fecha actual
        
        // Crea una nueva fecha con el año y mes actual pero manteniendo el día, hora, etc., de `currentDate`
        if let newDate = calendar.date(from: components) {
            currentDate = newDate
        }
    }
}

struct CalendarView: View {    
    @State private var calendarData = CalendarData()
    @State private var tapped = Array(repeating: false, count: 32)
    @State private var isModalPresented = false
    
    // State to handle flow with the modal
    @State private var selectedDate = ""
    @State private var selectedDateKey = ""
    @State private var feelingSelected = 0
    @State private var dateFeelingMap: [String: Int] = [:]
    
    
    fileprivate func handleTapOnDay(day: Int, month: Int, year: Int) {
        let selectedDate = calendarData.createDate(year: year, month: month, day: Int(day))
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
                            handleTapOnDay(
                                day: Int(day) ?? 1,
                                month: Int(calendarData.monthSelectedString()) ?? 1,
                                year: Int(calendarData.yearSelectedString()) ?? 1991
                            )
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

            VStack {
                Text("Log Today Feelings")
                    .frame(maxWidth: .infinity, minHeight: 75)
                    .background(Color.blue.opacity(0.3))
                    .foregroundColor(Color.blue)
                    .cornerRadius(5)
                    .onTapGesture {
                        let today = Date()
                        let calendar = Calendar.current
                        let day = calendar.component(.day, from: today)
                        let month = calendar.component(.month, from: today)
                        let year = calendar.component(.year, from: today)
                        handleTapOnDay(day: day, month: month, year: year)
                        calendarData.goToCurrentMonth()
                    }
            }
            .padding(.horizontal)
            
        }
        .sheet(isPresented: $isModalPresented) {
            ModalView(
                selectedDate: $selectedDate,
                selectedDateKey: $selectedDateKey,
                feelingSelected: $feelingSelected,
                onSelectFeeling: onSelectFeeling
            )
        }
        .onAppear {
            // Update state with the data from the store.
            updateDateFeelingMap()
        }
    }
    
    // Call functions to save (Currently 2)
    func onSelectFeeling(selectedDateKey: String, feelingSelected: Int) -> Void {
        // To save it temporaly
        saveFeeling(date_string: selectedDateKey, feeling: String(feelingSelected))
    }
    
    // Transform a "yyyyMMdd" to a Date() type output
    func fromStringToDate(date_string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Configuración regional neutral
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Zona horaria UTC

        return dateFormatter.date(from: date_string) ?? Date()
    }
    
    func saveFeeling(date_string: String, feeling: String) {
        let date_time = fromStringToDate(date_string: date_string)
        
        let newFeelingLog = NSEntityDescription.insertNewObject(forEntityName: "FeelingEntity", into: managedObjectContext)
        newFeelingLog.setValue(date_string, forKey: "date_string")
        newFeelingLog.setValue(feeling, forKey: "feeling")
        newFeelingLog.setValue(date_time, forKey: "date_time")

        do {
            try managedObjectContext.save()
            updateDateFeelingMap()
        } catch let error as NSError {
            // Manejar el error
            print("No se pudo guardar. \(error), \(error.userInfo)")
        }
            
    }
    
    
    func updateDateFeelingMap() {
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

    
    func fetchFeelings() -> [FeelingEntity] {
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
