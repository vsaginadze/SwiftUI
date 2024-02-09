//
//  CardView.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 06.02.2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        content
            .padding(Constants.Pie.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private var content: some View {
        Pie(endAngle: Angle(degrees: 240))
            .opacity(Constants.Pie.opacity)
            .overlay(
            Text(card.content)
                .font(.system(size: Constants.FontSize.largest))
                .minimumScaleFactor(Constants.FontSize.scaleFactor)
                .aspectRatio(1, contentMode: .fit)
                .multilineTextAlignment(.center)
                .padding(Constants.inset)
                .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                .animation(.spin(duration: 1.3), value: card.isMatched)
            )
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
}

extension Animation {
    static func spin(duration: CGFloat) -> Animation {
        linear(duration: duration).repeatForever(autoreverses: false)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                CardView(Card(content: "X", id: "test1"))
            }
            
            HStack {
                CardView(Card(content: "X", id: "test1"))
                CardView(Card(isFaceUp: true, content: "This is a very long text and I hope it fits", id: "test1"))
            }
        }
        .padding()
        .foregroundStyle(.green)
    }
}
