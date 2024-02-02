//
//  ContentView.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 31.01.2024.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["👻", "👹", "🕷️", "🎃", "🕸️", "🧙‍♀️", "🧟", "🧛‍♂️", "🍭"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<cardCount, id: \.self) { idx in
                    CardView(content: emojis[idx])

                }
            }
            .foregroundColor(.orange)

            HStack {
                cardRemover
                Spacer()
                cardAdder
            }
            .imageScale(.large)
            .font(.largeTitle)
        }
        .padding()
    }
    
    var cardRemover: some View {
        Button(action: {
            if cardCount > 1 {
                cardCount -= 1
            }
        }, label: {
            Image(systemName: "rectangle.stack.fill.badge.minus")
        })
    }
    
    var cardAdder: some View {
        Button(action: {
            if cardCount < emojis.count {
                cardCount += 1
            }
        }, label: {
            Image(systemName: "rectangle.stack.fill.badge.plus")
        })
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        } .onTapGesture {
            isFaceUp.toggle()
            print("tapped")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
