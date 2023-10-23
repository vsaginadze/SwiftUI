//
//  ContentView.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 04.09.2023.
//

import SwiftUI

struct ContentView: View {
    let themes: [String : Array<String>] = [
        "halloween": ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"],
        "vehicles": ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚚", "🛵"],
        "animals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
    ]
    
    @State var currentTheme = ""
    @State var shuffledTheme: [String] = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"]
    
   
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            ScrollView {
                cards
            }
            
            Spacer()
            
            themesButtons
        }
        .padding()
    }
    
    var themesButtons: some View {
        HStack {
            showTheme(theme: "Vehicles", displayAs: "car")
            showTheme(theme: "Animals", displayAs: "hare")
            showTheme(theme: "Halloween", displayAs: "moon")
        }
        .imageScale(.large)
        .foregroundColor(.accentColor)
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
            ForEach(shuffledTheme.indices, id:\.self) { index in
                CardView(content: shuffledTheme[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func showTheme(theme name: String, displayAs emoji: String) -> some View {
        Button {
            currentTheme = name.lowercased()
            shuffleCurrentTheme()
        } label: {
            VStack {
                Image(systemName: emoji)
                    .font(.title)
                Text(name)
            }
        }
    }
    
    func shuffleCurrentTheme() {
        if let currentThemeArray = themes[currentTheme] {
            shuffledTheme = currentThemeArray.shuffled()
        }
    }
    
//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: "rectangle.stack.fill.badge.\(symbol)")
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > hallowen.count)
//    }
//
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "minus")
//    }
//
//    var cardAdder: some View {
//        cardCountAdjuster(by: 1, symbol: "plus")
//    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
