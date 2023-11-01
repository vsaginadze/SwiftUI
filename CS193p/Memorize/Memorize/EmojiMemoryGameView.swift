//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 04.09.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let themes: [String : Array<String>] = [
        "halloween": ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"],
        "vehicles": ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚚", "🛵"],
        "animals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
    ]
    
    @State var currentTheme = ""
    @State var shuffledTheme: [String] = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"]
    
   
    var body: some View {
        VStack {
//            Text("Memorize!")
//                .font(.largeTitle)
            
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            HStack {
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                
                Spacer()
                
                Button("New Game") {
                    viewModel.restoreCards()
                }
            }
//
//            themesButtons
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
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
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
