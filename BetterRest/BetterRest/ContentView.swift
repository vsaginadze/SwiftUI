//
//  ContentView.swift
//  BetterRest
//
//  Created by Vakhtang Saginadze on 07.04.2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
   
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter the time", selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }

                Section {
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }
                Section{
                    Picker("Number of cups", selection: $coffeAmount) {
                            ForEach(1..<21) { number in
                                Text("\(number)")
                            }
                        }
                } header: {
                    Text("Daily coffe intake")
                        .font(.headline)
                }
                
                Section {
                   Text("\(calculateBedtime())")
                } header: {
                    Text("Recommended time to go to bed")
                        .font(.headline)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hours = (components.hour ?? 0) * 3600
            let minute = components.minute ?? 0 * 3600
            
            let prediction = try model.prediction(wake: Double(hours + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
