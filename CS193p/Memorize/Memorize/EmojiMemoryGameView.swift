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
            cards
            
            Button("Shuffle") {
                withAnimation {
                    viewModel.shuffle()
                }
            }
            .modifier(ButtonModifier(color: viewModel.getColor()))
        }
        .padding()
    }
    
    // TODO: FIX ratios
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
        .foregroundColor(viewModel.getColor())
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

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
