//
//  ContentView.swift
//  GuessingTheFlag
//
//  Created by Vakhtang Saginadze on 26.03.2023.
//

import SwiftUI

struct FlagImage: View {
    var flag: String
    
    var body: some View {
        Image(flag)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var number = Int.random(in: 0...2)
    @State private var rotationAngles: [Double] = [0, 0, 0]
    @State private var imageOpacities: [Double] = [1, 1, 1]
    @State private var scales: [Double] = [1,1,1]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.65, green: 0.1, blue: 0.3), location: 0.36)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag 🚩")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        
                        Text("\(countries[number])")
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                rotationAngles[number] += 360
                                scales[number] = 1.3
                                
                                for i in 0..<3  {
                                    if (i != number) {
                                        rotationAngles[i] -= 360
                                        imageOpacities[i] = 0.25
                                        scales[i] = 0.7
                                    }
                                }
                            }
                            flagWasTapped(choice: number)
                        }
                        label: {
                            FlagImage(flag: countries[number])
                                .rotation3DEffect(.degrees(rotationAngles[number]), axis: (x: 0, y: 1, z: 0))
                                .opacity(imageOpacities[number])
                                .scaleEffect(scales[number])
                        } .alert(scoreTitle, isPresented: $showingScore) {
                            Button("Continue") {
                                withAnimation {
                                    askQuestion()
                                } // is there a way to execute this on one line?
                            }
                        } message: {
                            Text("Your score is \(score)")
                        }
                    }
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
                
            }.padding()
        }
    }
    
    func newGame() {
        scoreTitle = ""
        score = 0
        showingScore = false
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        number = Int.random(in: 0...2)
        imageOpacities = [1,1,1]
        scales = [1,1,1]
    }
    
    func flagWasTapped(choice: Int) {
        if (score >= 0) {
            if (choice == number) {
                score += 1
                scoreTitle = "Correct"
            } else {
                scoreTitle = "Wrong"
                score -= 1
            }
        } else {
            newGame()
            scoreTitle = "New Game"
        }
        
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
