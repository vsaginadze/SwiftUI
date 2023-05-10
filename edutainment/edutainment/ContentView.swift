//
//  ContentView.swift
//  edutainment
//
//  Created by Vakhtang Saginadze on 17.04.2023.
//

import SwiftUI

struct Question {
    var text: String
    var answer: Int
}

struct ContentView: View {
    @State private var table = 2
    @State private var numberOfQuestionsArray = [5, 10, 20]
    @State private var questionNumber = 5
    
    var body: some View {
        NavigationStack {
            Stepper("pick a table \(table)", value: $table, in: 2...12, step: 1)
            
            Section {
                Picker("Tip Value", selection: $questionNumber) {
                       ForEach(numberOfQuestionsArray, id: \.self) {
                           Text($0, format: .number)
                       }
                }.pickerStyle(.segmented)
            } header: {
                Text("Pick number of questions")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 table
 
 */
