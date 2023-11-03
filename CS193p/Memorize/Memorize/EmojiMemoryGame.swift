//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 23.10.2023.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card

    private static let emojisList: [[String]] = [
        ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"],
        ["❄️","⛄","🎿","🧣","☕","🌨️","🎄","🔥","🧤"],
        ["🌌","🚀","🪐","👽","🛸","🌠","🔭","🪐","🛰️"],
        ["🐠","🐙","🦑","🦀","🐬","🌊","🐋","🐚","🦐"],
        ["🦁","🐘","🦒","🦓","🦏","🌿","🦜","🌾","🌍"],
        ["🌴","🍹","🏖️","🌺","🐠","🌞","🕶️","🍍","🍉"],
        ["⚔️","🛡️","🏰","🗡️","👑","🛡️","🐉","🏹","🪙"],
    ]
    private static var numberOfPairsList = (0..<names.count).map { _ in Int.random(in: 6...8)}
    private static let colors: [Color] = [.orange, .cyan, .purple, .blue, .safari, .green, .black]
    private static let names = ["halloween", "winter", "space", "ocean", "safari", "tropical", "medieval"]
    // TODO: - Put Data in JSON
    
    
    // TODO: Create with name
    // Try to create a memory game with theme's name instead of it's id
//    private static var theme: Theme = Theme(for: Int.random(in: 0..<names.count))
    
    // creates memory game using an id of a theme
    private static func createMemoryGame(forTheme idx: Int = 0) -> MemoryGame<String> {
        print(numberOfPairsList[idx])
        return MemoryGame(numberOfPairsOfCards: numberOfPairsList[idx]) { pairIndex in
            if emojisList[idx].indices.contains(pairIndex) {
                return emojisList[idx][pairIndex]
            } else {
                return "🫠" // retrieve this emoji from themes
            }
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func updateTheme(_ idx: Int) {
        model = EmojiMemoryGame.createMemoryGame(forTheme: idx)
//        EmojiMemoryGame.theme = Theme(for: idx)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restoreCards() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func getColor() -> Color {
//        return EmojiMemoryGame.theme.color
        return .orange
    }
    
    func getNames() -> [String] {
        // TODO: return the keys of dictionary (dictioanry is themes and keys will be names) instead of an array
        return ["halloween", "winter", "space", "ocean", "safari", "tropical", "medieval"]
    }
    
    struct Theme {
        var id: Int
        let name: String
        let emojis: [String]
        let numberOfPairs: Int
        let color: Color
        
        init(for id: Int) {
            self.id = id
            self.name = names[id]
            self.emojis = emojisList[id]
            self.numberOfPairs = numberOfPairsList[id]
            self.color = colors[id]
        }
    }
}

extension Color {
    static let safari = Color(red: 241 / 255, green: 99 / 255, blue: 38 / 255)
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
