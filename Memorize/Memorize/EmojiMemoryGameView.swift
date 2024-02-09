//
//  ContentView.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 31.01.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.color)
            
            HStack {
                score
                
                Spacer()
                
                shuffleButton
            }
            .font(.title2)
            .fontWeight(.medium)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 3)) {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel:  EmojiMemoryGame())
    }
}
