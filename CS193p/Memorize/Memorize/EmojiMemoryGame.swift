//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 23.10.2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"]
    private static let emoji2 = ["❄️","⛄","🎿","🧣","☕","🌨️","🎄","🔥","🧤"]
    private static let emoji3 = ["🌌","🚀","🪐","👽","🛸","🌠","🔭","🪐","🛰️"]
    private static let emoji4 = ["🐠","🐙","🦑","🦀","🐬","🌊","🐋","🐚","🦐"]
    private static let emoji5 = ["🦁","🐘","🦒","🦓","🦏","🌿","🦜","🌾","🌍"]
    private static let emoji6 = ["🌴","🍹","🏖️","🌺","🐠","🌞","🕶️","🍍","🍉"]
    private static let emoji7 = ["⚔️","🛡️","🏰","🗡️","👑","🛡️","🐉","🏹","🪙"]

    
    
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 16) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "🫠"
            }
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func restoreCards() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}


/*
 private static let themesDict: [String: [String]] = [
     "halloween": ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"],
     "winter": ["❄️","⛄","🎿","🧣","☕","🌨️","🎄","🔥","🧤"],
     "space": ["🌌","🚀","🪐","👽","🛸","🌠","🔭","🪐","🛰️"],
     "ocean": ["🐠","🐙","🦑","🦀","🐬","🌊","🐋","🐚","🦐"],
     "safari": ["🦁","🐘","🦒","🦓","🦏","🌿","🦜","🌾","🌍"],
     "tropical": ["🌴","🍹","🏖️","🌺","🐠","🌞","🕶️","🍍","🍉"],
     "medieval": ["⚔️","🛡️","🏰","🗡️","👑","🛡️","🐉","🏹","🪙"]
 ]

 
 */
