//
//  File.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 03.02.2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { idx in cards[idx].isFaceUp }.only }
        set { cards.indices.forEach { idx in cards[idx].isFaceUp = (idx == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        
                        score += 2
                    } else {
                        if (cards[chosenIndex].hasBeenSeen ||
                            cards[potentialMatchIndex].hasBeenSeen
                        ) {
                            score -= 1
                        }
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            """
            __\(id): \(content) \(isFaceUp ? "up" : "down")
            \(isMatched ? "matched" : "not fucking matched")__
            """
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
