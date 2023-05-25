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
    @State private var numberOfQuestion = 5
    @State private var gameIsOn = false
    @State private var questionNumber = 1
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score = 0
    
    var body: some View {
        Group {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                if (gameIsOn) {
                    VStack {
                        var questions = generateQuestions(table: table, numberOfQuestion: numberOfQuestion)
                        let question = questions.popLast()
                        
                        let possibleAnswers = possibleAnswer(answer: question!.answer)
                        
                        Text("Question \(questionNumber)")
                        Text("What is \(question!.text)")
                        
                        ForEach(0..<4) { number in
                            Button {
                                choiceWasTapped(choice: possibleAnswers[number], answer: question!.answer)
                            } label: {
                                Text("\(possibleAnswers[number])")
                                    .foregroundColor(.white)
                                    .padding(20)
                                    .frame(width: 150)
                                    .background(.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } .alert(scoreTitle, isPresented: $showingScore) {
                                Button("Continue") {
                                }
                            } message: {
                                Text("Your score is \(score)")
                            }
                        }
                    }
                } else {
                    VStack {
                        Stepper("pick a table \(table)", value: $table, in: 2...12, step: 1)
                        
                        Section {
                            Picker("Tip Value", selection: $numberOfQuestion) {
                                ForEach(numberOfQuestionsArray, id: \.self) {
                                    Text($0, format: .number)
                                }
                            }.pickerStyle(.segmented)
                        } header: {
                            Text("Pick number of questions")
                        }
                        
                        Button {
                            withAnimation {
                                gameIsOn = true
                            }
                        } label: {
                            Text("Start Game")
                        }
                    }
                }
            }
        }
    }
 
    func generateQuestions(table: Int, numberOfQuestion: Int) -> [Question] {
        var questions: [Question] = []
        
        for _ in 1...numberOfQuestion {
            let randomNumber = Int.random(in: 1...10)
            let questionText = "\(table) * \(randomNumber)"
            let answer = table * randomNumber
            
            let question = Question(text: questionText, answer: answer)
            questions.append(question)
        }
            
        return questions
    }
    
    func newGame() {
        score = 0
        scoreTitle = ""
        showingScore = false
        gameIsOn = false
        numberOfQuestion = 5
        questionNumber = 0
    }
    
    func choiceWasTapped(choice: Int, answer: Int) {
        if (questionNumber < numberOfQuestion) {
            if (choice == answer) {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Incorrect"
            }
            showingScore = true
        } else {
            withAnimation {
                newGame()
            }
        }
        questionNumber += 1
    }
    
    func possibleAnswer(answer: Int) -> [Int] {
        var possibleAnswers = [Int]()
        
        possibleAnswers.append(answer)
        while possibleAnswers.count <= 3 {
            let choice = Int.random(in: answer-4...answer+4)
            if !possibleAnswers.contains(choice) && choice > 0 {
                possibleAnswers.append(choice)
            }
        }
        possibleAnswers.shuffle()
        return possibleAnswers
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
