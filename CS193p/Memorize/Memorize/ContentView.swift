//
//  ContentView.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 04.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            if (isFaceUp) {
                Rectangle()
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("👻")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
