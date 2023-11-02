//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 04.09.2023.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    let names = ["halloween", "winter", "space", "ocean", "safari", "tropical", "medieval"]
    let aspectRatio : CGFloat = 2/3
    
    @State private var currentTheme = "halloween"

    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            GeometryReader { geomtry in
                ScrollView {
                    cards
                        .animation(.default, value: viewModel.cards)
                }
            }
            
            HStack {
                
                Button(action: viewModel.shuffle) {
                    Text("Shuffle")
                        .modifier(ButtonModifier(color: viewModel.getColor()))
                }
                
                Spacer()
                
                Button(action: viewModel.restoreCards) {
                    Text("New Game")
                        .modifier(ButtonModifier(color: viewModel.getColor()))
                }
                
            }
        }
        .padding()
    }
    
    var themesList: some View {
        Picker("Select a paint color", selection: $currentTheme) {
            ForEach(names, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.menu)
        .onChange(of: currentTheme) { newValue in
            viewModel.updateTheme(names.firstIndex(of: newValue) ?? 0)
        }
    }
    
    // TODO: FIX ratios
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
            }
        }
        .foregroundColor(viewModel.getColor())
    }
    
    
    
    struct ButtonModifier: ViewModifier {
        var color: Color
        
        func body(content: Content) -> some View {
            content
                .foregroundColor(.white)
                .padding(15)
                .background(color.opacity(0.7))
                .cornerRadius(10)
                
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
