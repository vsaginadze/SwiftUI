//
//  ContentView.swift
//  InsultX
//
//  Created by Vakhtang Saginadze on 26.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var nameToRoast = "X"
    @State private var newName = ""
    
    var names = ["Paul", "Nick", "George"]
    
    let insults = [
        "You're as useless as the 'ueue' in 'queue'.",
        "You're not pretty enough to have such an ugly personality.",
        "Your face looks like it was on fire and someone tried to put it out with a fork.",
        "I would insult you, but nature has already done such a good job.",
        "You're about as useful as a screen door on a submarine.",
        "I bet your parents change the subject when their friends ask about you.",
        "You're the human equivalent of a participation award.",
        "You have a face made for radio.",
        "I've seen more life in a used condom.",
        "You're like Monday mornings, nobody likes you."
    ]
    @State private var insult = "Insult"
    
    func generateNewInsult() -> String {
        var insult = insults.randomElement()
        insult = insult?.replacingOccurrences(of: "You", with: nameToRoast)
        
        return insult ?? "X"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Name to roast", selection: $nameToRoast) {
                        ForEach(names, id: \.self) {
                            Text($0)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Pick a person to roast")
                }
                
                Section {
                    Button("\(insult)") {
                        insult = generateNewInsult()
                    }
                } header: {
                    Text("Tap to Insult to roast \(nameToRoast)")
                }
            }.navigationTitle("Insult-\(nameToRoast)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
