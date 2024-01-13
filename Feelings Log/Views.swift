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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("How are you feeling today?")
                .font(.headline)
                .padding()
            Text(selectedDate)
                .font(.subheadline)
                .padding()

           Button("Good 😄") {
               // Acción para el botón 1
               self.presentationMode.wrappedValue.dismiss()
           }
            .frame(maxWidth: .infinity, minHeight: 75)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(22)
            .padding(.horizontal)
           
           Button("Normal 🙂") {
               // Acción para el botón 2
               self.presentationMode.wrappedValue.dismiss()
           }
            .frame(maxWidth: .infinity, minHeight: 75)
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(22)
            .padding(.horizontal)
            
           Button("Not Good 🙁") {
               // Acción para el botón 3
               self.presentationMode.wrappedValue.dismiss()
           }
            .frame(maxWidth: .infinity, minHeight: 75)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(22)
            .padding(.horizontal)
           
           Spacer()
           
           Button("Cerrar") {
               self.presentationMode.wrappedValue.dismiss()
           }
          
       }
    }
}
