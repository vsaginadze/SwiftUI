//
//  CardView.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 03.11.2023.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card

    let card: Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(0.4)
            .overlay(
                Text(card.content)
                    .font(.system(size: 200))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.001)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(7)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.spin(duration: 1), value: card.isMatched)
            )
        .padding(5)
        .modifier(Cardify(isFaceUp: card.isFaceUp))
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                    .padding()
                    .foregroundColor(.green)
                CardView(Card(content: "X", id: "test1"))
                    .padding()
                    .foregroundColor(.green)
            }
            
            HStack {
                CardView(Card(isFaceUp: true, content: "This is very long string and I hope it fits", id: "test1"))
                    .padding()
                         
                CardView(Card(isMatched: true, content: "X", id: "test1"))
                    .padding()
            }
        }
        .padding()
    }
}
